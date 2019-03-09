(function($) {
	
	$.alerts = {
		
		// These properties can be read/written by accessing $.alerts.propertyName from your scripts at any time
		
		verticalOffset: -75,                // vertical offset of the dialog from center screen, in pixels
		horizontalOffset: 0,                // horizontal offset of the dialog from center screen, in pixels/
		repositionOnResize: true,           // re-centers the dialog on window resize
		overlayOpacity: .01,                // transparency level of overlay
		overlayColor: '#FFF',               // base color of overlay
		draggable: true,                    // make the dialogs draggable (requires UI Draggables plugin)
		okButton: '&nbsp;OK&nbsp;',         // text for the OK button
		cancelButton: '&nbsp;Cancel&nbsp;', // text for the Cancel button
		dialogClass: null,                  // if specified, this class will be applied to all dialogs
		
		// Public methods
		
		alert: function(message, title, alertType, callback) {
			if( title == null ) title = 'Alert';
			$.alerts._show(title, message, null, alertType, 'alert', function(result) {
				if( callback ) callback(result);
			});
		},
		
		confirm: function(message, title, callback) {
			if( title == null ) title = 'Confirm';
			$.alerts._show(title, message, null, null,'confirm', function(result) {
				if( callback ) callback(result);
			});
		},
			
		
		// Private methods
		
		_show: function(title, msg, value, alertType, type, callback) {
			
			$.alerts._hide();
			$.alerts._overlay('show');
			
			$("BODY").append(
			  '<div id="popup_container">' +
			    '<h1 id="popup_title"></h1>' +
			    '<div id="popup_content">' +
			      '<div id="popup_message"></div>' +
				'</div>' +
			  '</div>');
			
			if( $.alerts.dialogClass ) $("#popup_container").addClass($.alerts.dialogClass);
			
			// IE6 Fix
			var pos = ($.browser.msie && parseInt($.browser.version) <= 6 ) ? 'absolute' : 'fixed'; 
			
			$("#popup_container").css({
				position: pos,
				zIndex: 99999,
				width:'400px',
				padding: 0,
				margin: 0
			});
			
			$("#popup_title").text(title);
			
			switch( alertType ) {
				case 'alert':
					
					$("#popup_container").css({
					border: '1px solid #219DF3',
					background:'#fff'
					});	
				
					$("#popup_title").css({
						'font-size': '14px',
						'font-weight': 'bold',
						'text-align': 'center',
						'line-height': '1.75em',
						padding: '0em',
						margin: '0em',
						color: '#fff',
						background: '#219DF3'
					});
				break;
				
				case 'warn':
					$("#popup_container").css({
					border: '1px solid #FFEDAB',
					background:'#fff'
					});
					$("#popup_title").css({
						'font-size': '14px',
						'font-weight': 'bold',
						'text-align': 'center',
						'line-height': '1.75em',
						padding: '0em',
						margin: '0em',
						color: '#7f6400',
						background:'#FFEDAB'
					});
				break;
				
				case 'error':
					$("#popup_container").css({
					border: '1px solid #FFB3B3',
					background:'#fff'
					});
					$("#popup_title").css({
						'font-size': '14px',
						'font-weight': 'bold',
						'text-align': 'center',
						'line-height': '1.75em',
						padding: '0em',
						margin: '0em',
						color: '#8e2500',
						background: '#FFB3B3'
					});
				break;				
				
			}

			
			
			$("#popup_content").css({
				background: 'none',
				padding:'10px',
				margin: '0em'
			});
			
						
			$("#popup_message").text(msg);
			$("#popup_message").html( $("#popup_message").text().replace(/\n/g, '<br />') );
			
			
			
			$.alerts._reposition();
			$.alerts._maintainPosition(true);
			
			switch( type ) {
				case 'alert':
					
					$("#popup_message").after('<div id="popup_panel"><input type="button" value="' + $.alerts.okButton + '" id="popup_ok" /></div>');
					$("#popup_ok").click( function() {
						$.alerts._hide();
						callback(true);
					});
					$("#popup_ok").focus().keypress( function(e) {
						if( e.keyCode == 13 || e.keyCode == 27 ) $("#popup_ok").trigger('click');
					});
				break;
				case 'confirm':
					$("#popup_container").css({
					border: '1px solid #219DF3',
					background:'#fff'
					});	
				
					$("#popup_title").css({
						'font-size': '14px',
						'font-weight': 'bold',
						'text-align': 'center',
						'line-height': '1.75em',
						padding: '0em',
						margin: '0em',
						color: '#fff',
						background: '#219DF3'
					});
					
					
				
					$("#popup_message").after('<div id="popup_panel"><input type="button" value="' + $.alerts.okButton + '" id="popup_ok" /> <input type="button" value="' + $.alerts.cancelButton + '" id="popup_cancel" /></div>');
					
					$("#popup_ok").css({
					padding: '.4em 1em',
					color: '#fff',
					background:'#219DF3',
					border:'0 none',
					cursor:'pointer'
					});
					
					$("#popup_cancel").css({
					padding: '.4em 1em',
					color: '#333',
					background:'#eaeaea',
					border:'0 none',
					cursor:'pointer'
					});
					
					$("#popup_ok").click( function() {
						$.alerts._hide();
						if( callback ) callback(true);
					});
					$("#popup_cancel").click( function() {
						$.alerts._hide();
						if( callback ) callback(false);
					});
					$("#popup_ok").focus();
					$("#popup_ok, #popup_cancel").keypress( function(e) {
						if( e.keyCode == 13 ) $("#popup_ok").trigger('click');
						if( e.keyCode == 27 ) $("#popup_cancel").trigger('click');
					});
				break;
			}
			
			
			switch( alertType ) {
			case 'alert':
				$("#popup_ok").css({
					padding: '.4em 1em',
					color: '#fff',
					background: '#219DF3',
					border:'0 none',
					cursor:'pointer'
					});
			break;
			
			case 'warn':
				$("#popup_ok").css({
					padding: '.4em 1em',
					color: '#7f6400',
					background:'#FFEDAB',
					border:'0 none',
					cursor:'pointer'
					});
			break;
			
			case 'error':
				$("#popup_ok").css({
					padding: '.4em 1em',
					color: '#8e2500',
					background: '#FFB3B3',
					border:'0 none',
					cursor:'pointer'
					});
			break;
			
			
		}
			
			$("#popup_container.style_1").css({
				'font-family': 'Georgia, serif',
				'color': '#A4C6E2',
				'background': '#005294',
				'border-color': '#113F66'
			});
			$("#popup_container.style_1 #popup_title").css({
				'color': '#FFF',
				'font-weight': 'normal',
				'text-align': 'left',
				'background': '#76A5CC',
				'border': 'solid 1px #005294',
				'padding-left': '1em'
			});
			
			$("#popup_container").css({
				minWidth: $("#popup_container").outerWidth(),
				maxWidth: $("#popup_container").outerWidth()
			});
			$("#popup_container.style_1 #popup_content").css({
				background: 'none'
			});
			$("#popup_container.style_1 #popup_message").css({
				'padding-left': '0em'
			});
			
			$("#popup_panel").css({ 'text-align':'center', 'padding-top':'10px'});
			
			// Make draggable
			if( $.alerts.draggable ) {
				try {
					$("#popup_container").draggable({ handle: $("#popup_title") });
					$("#popup_title").css({ cursor: 'move' });
				} catch(e) { /* requires jQuery UI draggables */ }
			}
		},
		
		_hide: function() {
			$("#popup_container").remove();
			$.alerts._overlay('hide');
			$.alerts._maintainPosition(false);
		},
		
		_overlay: function(status) {
			switch( status ) {
				case 'show':
					$.alerts._overlay('hide');
					$("BODY").append('<div id="popup_overlay"></div>');
					$("#popup_overlay").css({
						position: 'absolute',
						zIndex: 99998,
						top: '0px',
						left: '0px',
						width: '100%',
						height: $(document).height(),
						background: $.alerts.overlayColor,
						opacity: $.alerts.overlayOpacity
					});
				break;
				case 'hide':
					$("#popup_overlay").remove();
				break;
			}
		},
		
		_reposition: function() {
			var top = (($(window).height() / 2) - ($("#popup_container").outerHeight() / 2)) + $.alerts.verticalOffset;
			var left = (($(window).width() / 2) - ($("#popup_container").outerWidth() / 2)) + $.alerts.horizontalOffset;
			if( top < 0 ) top = 0;
			if( left < 0 ) left = 0;
			
			// IE6 fix
			if( $.browser.msie && parseInt($.browser.version) <= 6 ) top = top + $(window).scrollTop();
			
			$("#popup_container").css({
				top: top + 'px',
				left: left + 'px'
			});
			$("#popup_overlay").height( $(document).height() );
		},
		
		_maintainPosition: function(status) {
			if( $.alerts.repositionOnResize ) {
				switch(status) {
					case true:
						$(window).bind('resize', function() {
							$.alerts._reposition();
						});
					break;
					case false:
						$(window).unbind('resize');
					break;
				}
			}
		}
		
	}
	
	// Shortuct functions
	jAlert = function(message, title, callback) {
		$.alerts.alert(message, title, callback);
	}
	
	jConfirm = function(message, title, callback) {
		$.alerts.confirm(message, title, callback);
	};
		
	
})(jQuery);