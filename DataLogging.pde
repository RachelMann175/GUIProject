// return previous inputs for stimulus pulse width
public void GetStimPWInformation(){
  for(int i = 0; i < tc.getStimPWInformation().size(); i++){
    int pw = tc.getStimPWInformation().get(i);
    System.out.println("Recorded stimulus pulse widths: " + pw);
  }
}

// return previous inputs for interpulse delay
public void GetInterpulseDelayInformation(){
  for(int i = 0; i < tc.getInterpulseDelayInformation().size(); i++){
    int id = tc.getInterpulseDelayInformation().get(i);
    System.out.println("Recorded interpulse delay: " + id);
  }
}

// return previous inputs for recharge pulse width
public void GetRechargePWInformation(){
  for(int i = 0; i < tc.getRechargePulseWidthInformation().size(); i++){
    int rpw = tc.getRechargePulseWidthInformation().get(i);
    System.out.println("Recorded recharge pulse width: " + rpw);
  }
}

// return previous inputs for pulse period
public void GetPulsePeriodInformation(){
  for(int i = 0; i < tc.getPulsePeriodInformation().size(); i++){
    int pp = tc.getPulsePeriodInformation().get(i);
    System.out.println("Recorded pulse period: " + pp);
  }
}

// return previous inputs for channel 1 stim: sink
public void GetChannel1StimSinkInfo(){
  for(int i = 0; i < channel1StimSinkInfo.size(); i++){
    int c1sSink = channel1StimSinkInfo.get(i);
    System.out.println("Recorded channel 1 stim sink amplitude: " + c1sSink);
  }
}

public void GetChannel1StimSourceInfo(){
  for(int i = 0; i < channel1StimSourceInfo.size(); i++){
    int c1sSource = channel1StimSourceInfo.get(i);
    System.out.println("Recorded channel 1 stim source amplitude: " + c1sSource);
  }
}

public void GetChannel2StimSinkInfo(){
  for(int i = 0; i < channel2StimSinkInfo.size(); i++){
    int c2sSink = channel2StimSinkInfo.get(i);
    System.out.println("Recorded channel 2 stim sink amplitude: " + c2sSink);
  }
}

public void GetChannel2StimSourceInfo(){
  for(int i = 0; i < channel2StimSourceInfo.size(); i++){
    int c2sSource = channel2StimSourceInfo.get(i);
    System.out.println("Recorded channel 2 stim source amplitude: " + c2sSource);
  }
}

public void GetChannel1RchrgSinkInfo(){
  for(int i = 0; i < channel1RchrgSinkInfo.size(); i++){
    int c1rSink = channel1RchrgSinkInfo.get(i);
    System.out.println("Recorded channel 1 recharge sink amplitude: " + c1rSink);
  }
}

public void GetChannel1RchrgSourceInfo(){
  for(int i = 0; i < channel1RchrgSourceInfo.size(); i++){
    int c1rSource = channel1RchrgSourceInfo.get(i);
    System.out.println("Recorded channel 1 recharge source amplitude: " + c1rSource);
  }
}

public void GetChannel2RchrgSinkInfo(){
  for(int i = 0; i < channel2RchrgSinkInfo.size(); i++){
    int c2rSink = channel2RchrgSinkInfo.get(i);
    System.out.println("Recorded channel 2 recharge sink amplitude: " + c2rSink);
  }
}

public void GetChannel2RchrgSourceInfo(){
  for(int i = 0; i < channel2RchrgSourceInfo.size(); i++){
    int c2rSource = channel2RchrgSourceInfo.get(i);
    System.out.println("Recorded channel 2 recharge sink amplitude: " + c2rSource);
  }
}

public void ClearPulseTimings() {
  cp5.get(Textfield.class,"Stim PW (us)").clear();
  cp5.get(Textfield.class,"Interpulse Delay (us)").clear();
  cp5.get(Textfield.class,"Recharge PW (us)").clear();
  cp5.get(Textfield.class,"Pulse Period (ms)").clear();
  tc.getStimPWInformation().clear();
  tc.getInterpulseDelayInformation().clear();
  tc.getRechargePulseWidthInformation().clear();
  tc.getPulsePeriodInformation().clear();
}

public void ClearAmplitudes() {
  cp5.get(Textfield.class,"Channel 1 Stim: Sink mA").clear();
  cp5.get(Textfield.class,"Channel 2 Stim: Source mA").clear();
  cp5.get(Textfield.class,"Channel 1 Rchrg: Source mA").clear();
  cp5.get(Textfield.class,"Channel 2 Rchrg: Sink mA").clear();
  channel1StimSinkInfo.clear();
  channel1StimSourceInfo.clear();
  channel2StimSinkInfo.clear();
  channel2StimSourceInfo.clear();
  channel1RchrgSinkInfo.clear();
  channel1RchrgSourceInfo.clear();
  channel2RchrgSinkInfo.clear();
  channel2RchrgSourceInfo.clear();
}
