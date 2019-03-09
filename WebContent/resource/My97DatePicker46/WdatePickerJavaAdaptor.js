/**
 * @author badqiu
 */
function WdatePickerJavaAdaptor(el,javaDateFmt,skin,onPicked) {
	var dateFmt = javaDateFmt.replace('yyyy','%Y');
	dateFmt = dateFmt.replace('MM','%M');
	dateFmt = dateFmt.replace('dd','%D');
	dateFmt = dateFmt.replace('HH','%h');
	dateFmt = dateFmt.replace('mm','%m');
	dateFmt = dateFmt.replace('ss','%s');
	var showTime = false;
	if(dateFmt.indexOf('%h') >= 0 || dateFmt.indexOf('%m') >= 0 || dateFmt.indexOf('%s') >= 0) {
		showTime = true;
	}
	return new WdatePicker(el,dateFmt,showTime,skin,onPicked);
}

function WdatePickerJavaAdaptor1(el,javaDateFmt,skin,onPicked) {
	var dateFmt = javaDateFmt.replace('yyyy','%Y');
	dateFmt = dateFmt.replace('MM','%M');
	dateFmt = dateFmt.replace('dd','%D');
	dateFmt = dateFmt.replace('HH','%h');
	dateFmt = dateFmt.replace('mm','%m');
	dateFmt = dateFmt.replace('ss','%s');
	var showTime = false;
	if(dateFmt.indexOf('%h') >= 0 || dateFmt.indexOf('%m') >= 0 || dateFmt.indexOf('%s') >= 0) {
		showTime = true;
	}
	return new WdatePicker(el,dateFmt,showTime,skin,onPicked);
}