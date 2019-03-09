package com.mp100.risk.ap.seats.thread;

import java.util.TimerTask;

import com.mp100.risk.ap.seats.util.SimilarUtil;

public class SimilarTask extends TimerTask{
	
	public void run() {  
		SimilarUtil.similarMatching("");
    }
}
