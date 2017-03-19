// Dynamic Unity (for fixed media), 2017, Philip Liu
  // Supercollider code for generating materials of the piece


//Requirements:
  //StoneChime0 to 3 and SCFrag5 to 46, 2d Membrane Physical Modeling UGens(Physical Model of
        //Stone Chime Instruments, procedually made variations from Korea's PyeonGyeong
        //to China's Bianqing)
  //Record.sc class file
  //for "1 Dimensional" part, Route.sc class file
  //for "2 Dimensional" part, CDP (Trevor Wishart)


//loading 15 residuals for excitation
(
~residualPath = "/Works_S/Sounds/SCResiduals/";
~res = (~residualPath++"*").pathMatch.collect{ arg path; Buffer.read(s,path)};
)


//////////////////////// 0 Dimensional : Points ///////////////////////

//Bus for recording
~audioBus1 = Bus.audio(s, 1);

(
SynthDef(\SCRec,
{
arg tension = 0.1, loss = 0.99999, synNum = 5;
		var hitBufChoice = [~res[0], ~res[1], ~res[2], ~res[3], ~res[4], ~res[5], ~res[6], ~res[7], ~res[8], ~res[9], ~res[10], ~res[11], ~res[12], ~res[13], ~res[14], ~res[15], ~res[16], ~res[17], ~res[18], ~res[19], ~res[20], ~res[21], ~res[22], ~res[23], ~res[24], ~res[25], ~res[26], ~res[27], ~res[28], ~res[29]];

		var excitation = EnvGen.kr(Env.perc(0.1.rand,1),
                       1,
                       timeScale: 0.1, doneAction: 0
                       ) *(1.5*PlayBuf.ar(1, hitBufChoice.choose , rate:1, loop: 0,  startPos: 0, trigger:1));
		//from UGen StoneChime0 ~ StoneChime3, SCFrag5 ~ SCFrag46, by hand. SCFrag46 = StoneChime0
		var num = synNum;
		var sig = SCFrag10.ar(excitation, tension, loss);

Out.ar(~audioBus1, sig);
DetectSilence.ar(sig, time:0.1);
}).send(s);


//function for Recording. automatic file name generation


~recFunc = {
arg rand1, rand2;
	~rec1 = Record("/Works_S/Sounds"++"/SCFrag"++10.asString++"_"++rand1.round(0.00001).asString++"_"++rand2.round(0.0000001).asString++".wav", ~audioBus1, 1,true);
~rec1.monitorOnOff_(true);

{
Synth(\SCRec, [\tension, rand1, \loss, rand2, \synNum, ~recNum]);
~rec1.start;
}.defer(0.01)
}
)


//Assign fixed + random value to tension and loss of the synth
(
// var val1 =  Pseq([0.015, 0.021, 0.38], 2).asStream;
// var val2 = Pstutter(3, Pseq([0.999999, 0.999],inf)).asStream;
// var val2 = PSeq([0.9999, 0.999999], 1).asStream;
var vall1, vall2;
// vall1 = 0.0146;
// vall1 = 0.022;
vall1 = 0.02;
// vall2 = 0.9999999;
vall2 = 0.999;

		~recFunc.value(vall1, vall2);
)

//////////////////////// 1 Dimensional : Lines ///////////////////////


//Env for moving tension
(
SynthDef(\SCEnv,{
		arg in, out, amp=1, gate = 1, atkTime = 3, envAdd = 0.004, envMul = 0.01, decayTime = 4;

		var envSig = envAdd+EnvGen.ar(Env.adsr(atkTime, decayTime, 0.2, 0.2), gate, levelScale: envMul);

		Out.ar(out, envSig);
DetectSilence.ar(envSig, time:0.1);

}).send(s);
)

//Generator
(
SynthDef(\SCRecSlide0,
{
arg tension, loss = 0.99999, in, out, amp;
		var hitBufChoice = [~res[0], ~res[1], ~res[2], ~res[3], ~res[4], ~res[5], ~res[6], ~res[7], ~res[8], ~res[9], ~res[10], ~res[11], ~res[12], ~res[13], ~res[14]];


var excitation = EnvGen.kr(Env.perc,
                       1,
                       timeScale: 0.1, doneAction: 0
                       ) *(2*PlayBuf.ar(1, hitBufChoice.choose , rate:1, loop: 0,  startPos: 0, trigger:1));
var sig = StoneChime0.ar(excitation, In.ar(in, 1), loss);

Out.ar(out, sig * amp);
DetectSilence.ar(sig, time:0.1);
}).send(s);

SynthDef(\SCRecSlide1,
{
arg tension, loss = 0.99999, in, out, amp;
		var hitBufChoice = [~res[0], ~res[1], ~res[2], ~res[3], ~res[4], ~res[5], ~res[6], ~res[7], ~res[8], ~res[9], ~res[10], ~res[11], ~res[12], ~res[13], ~res[14]];


var excitation = EnvGen.kr(Env.perc,
                       1,
                       timeScale: 0.1, doneAction: 0
                       ) *(3*PlayBuf.ar(1, hitBufChoice.choose , rate:1, loop: 0,  startPos: 0, trigger:1));
var sig = StoneChime1.ar(excitation, In.ar(in, 1), loss);

Out.ar(out, sig * amp);
DetectSilence.ar(sig, time:0.1);
}).send(s);

SynthDef(\SCRecSlide2,
{
arg tension, loss = 0.99999, in, out, amp;
		var hitBufChoice = [~res[0], ~res[1], ~res[2], ~res[3], ~res[4], ~res[5], ~res[6], ~res[7], ~res[8], ~res[9], ~res[10], ~res[11], ~res[12], ~res[13], ~res[14]];


var excitation = EnvGen.kr(Env.perc,
                       1,
                       timeScale: 0.1, doneAction: 0
                       ) *(3*PlayBuf.ar(1, hitBufChoice.choose , rate:1, loop: 0,  startPos: 0, trigger:1));
var sig = StoneChime2.ar(excitation, In.ar(in, 1), loss);

Out.ar(out, sig * amp);
DetectSilence.ar(sig, time:0.1);
}).send(s);

SynthDef(\SCRecSlide3,
{
arg tension, loss = 0.99999, in, out, amp;
		var hitBufChoice = [~res[0], ~res[1], ~res[2], ~res[3], ~res[4], ~res[5], ~res[6], ~res[7], ~res[8], ~res[9], ~res[10], ~res[11], ~res[12], ~res[13], ~res[14]];


var excitation = EnvGen.kr(Env.perc,
                       1,
                       timeScale: 0.1, doneAction: 0
                       ) *(2*PlayBuf.ar(1, hitBufChoice.choose , rate:1, loop: 0,  startPos: 0, trigger:1));
var sig = StoneChime3.ar(excitation, In.ar(in, 1), loss);

Out.ar(out, sig * amp);
DetectSilence.ar(sig, time:0.1);
}).send(s);
)



//Freezing for prolongation and to generate drone like tail
(
SynthDef(\SCFreeze, {
	                      //freezeTime means the time that the sound is going to be freezed
	                    //decay means the time that the sound is going to be unfreezed
arg in, out, amp, freezeTime = 10, decay = 4.0;
var sig = FFT(LocalBuf(4096), In.ar(in, 1));
	var freezeLine = (EnvGen.ar(Env.adsr(freezeTime*2, decay, 0, 1)) -0.5) * 2.0;
	// var freezeLine = Line.kr(-1, 1, freezeTime*2);

	sig = PV_Freeze(sig, freezeLine);
	sig = IFFT(sig);
	Out.ar(out, sig);
	DetectSilence.ar(sig, time:0.1);
}).send(s);
)


//Route class needs to be installed
r = Route(1);

//Bus for recording
~audioBus2 = Bus.audio(s, 1);

//function for recording
(
~slideRecFunc0 = {
arg atkVal, decayTime, freezeVal, decayVal, envAdd, envMul;
var ampOfFreeze = 3;

	//automatic file name generation
	~rec2 = Record("/Works_S/Sounds"++"/SCLine0"++"_"++atkVal.round(0.01).asString++"_"++decayTime.round(0.01).asString++"_"++freezeVal.round(0.01).asString++"_"++decayVal.round(0.01).asString++"_"++envAdd.round(0.0001).asString++"_"++envMul.round(0.0001).asString++".wav", ~audioBus2, true);
~rec2.monitorOnOff_(true);

{
		// Routing using Route class
r|>\SCEnv=>\SCRecSlide0=>\SCFreeze==~audioBus2;

r.syn[0].set(\atkTime, atkVal, \decayTime, decayTime, \envAdd, envAdd, \envMul, envMul);
r.syn[1].set(\amp, ampOfFreeze);
r.syn[2].set(\freezeTime, freezeVal, \decay, decayVal);
~rec2.start;
}.defer(0.01);

};

~slideRecFunc1 = {
arg atkVal, decayTime, freezeVal, decayVal, envAdd, envMul;
var ampOfFreeze = 3;

	//automatic file name generation
	~rec2 = Record("/Works_S/Sounds"++"/SCLine1"++"_"++atkVal.round(0.01).asString++"_"++decayTime.round(0.01).asString++"_"++freezeVal.round(0.01).asString++"_"++decayVal.round(0.01).asString++"_"++envAdd.round(0.0001).asString++"_"++envMul.round(0.0001).asString++".wav", ~audioBus2, true);
~rec2.monitorOnOff_(true);

{
		// Routing using Route class
r|>\SCEnv=>\SCRecSlide1=>\SCFreeze==~audioBus2;

r.syn[0].set(\atkTime, atkVal, \decayTime, decayTime, \envAdd, envAdd, \envMul, envMul);
r.syn[1].set(\amp, ampOfFreeze);
r.syn[2].set(\freezeTime, freezeVal, \decay, decayVal);
~rec2.start;
}.defer(0.01);

};

~slideRecFunc2 = {
arg atkVal, decayTime, freezeVal, decayVal, envAdd, envMul;
var ampOfFreeze = 3;

	//automatic file name generation
	~rec2 = Record("/Works_S/Sounds"++"/SCLine2"++"_"++atkVal.round(0.01).asString++"_"++decayTime.round(0.01).asString++"_"++freezeVal.round(0.01).asString++"_"++decayVal.round(0.01).asString++"_"++envAdd.round(0.0001).asString++"_"++envMul.round(0.0001).asString++".wav", ~audioBus2, true);
~rec2.monitorOnOff_(true);

{
		// Routing using Route class
r|>\SCEnv=>\SCRecSlide2=>\SCFreeze==~audioBus2;

r.syn[0].set(\atkTime, atkVal, \decayTime, decayTime, \envAdd, envAdd, \envMul, envMul);
r.syn[1].set(\amp, ampOfFreeze);
r.syn[2].set(\freezeTime, freezeVal, \decay, decayVal);
~rec2.start;
}.defer(0.01);

};

~slideRecFunc3 = {
arg atkVal, decayTime, freezeVal, decayVal, envAdd, envMul;
var ampOfFreeze = 3;

	//automatic file name generation
	~rec2 = Record("/Works_S/Sounds"++"/SCLine3"++"_"++atkVal.round(0.01).asString++"_"++decayTime.round(0.01).asString++"_"++freezeVal.round(0.01).asString++"_"++decayVal.round(0.01).asString++"_"++envAdd.round(0.0001).asString++"_"++envMul.round(0.0001).asString++".wav", ~audioBus2, true);
~rec2.monitorOnOff_(true);

{
		// Routing using Route class
r|>\SCEnv=>\SCRecSlide3=>\SCFreeze==~audioBus2;

r.syn[0].set(\atkTime, atkVal, \decayTime, decayTime, \envAdd, envAdd, \envMul, envMul);
r.syn[1].set(\amp, ampOfFreeze);
r.syn[2].set(\freezeTime, freezeVal, \decay, decayVal);
~rec2.start;
}.defer(0.02);

};
)

(
Task({
	//change variables manually or randomly to obtain desired sound
	//atkVal, freezeVal, decayVal going to be stored in a file name
	var atkVal = 1.5, decayTime = 10, ampVal = 2, freezeVal = 0.6, frzDecayVal = 0.7, envAdd = 0.012, envMul=0.003, recFunction = [~slideRecFunc1, ~slideRecFunc2];
	// loop
	1.do
	{
	atkVal = rrand(0.05, 6);
		decayTime = rrand(0.5, 2);
		freezeVal = rrand(0.1, 1);
		frzDecayVal = rrand(0.1, 5);
		// envMul = rrand(0.003, 0.1);

		recFunction.choose.value(atkVal, decayTime, freezeVal, frzDecayVal, envAdd, envMul);

		(atkVal+(freezeVal*2) + frzDecayVal + 5).wait;
		CmdPeriod.run;
		3.wait;
	}
}).start;
)


////// 2 Dimensional : Line+Point or Line+Line cross modulation //////

//CDP by Trevor Wishart, command function
//CDP needs to be installed to use this
(
~cdp = {|program, input, output, params|
	    var command;
	    command = program+"\""++input++"\""+"\""++output++"\""+params;
	    command.postln;
	    (command).runInTerminal;
    }
)

//collect point and line wav files
(
//save to /SCPlane directory
~outPath = "/Works_S/Sounds/SCPlane/";

~path0 = "/Works_S/Sounds/SCPoint/";
~bufferColl0 = List.newClear(0);
(~path0++"*").pathMatch.collect{ arg path; ~bufferColl0.add(path)};

~path1 = "/Works_S/Sounds/SCLine/";
~bufferColl1 = List.newClear(0);
(~path1++"*").pathMatch.collect{ arg path; ~bufferColl1.add(path)};
)

//generate files : CDP inbetween point or line, and line wav files
(
Task({
	1.do{
		var output;
		var filename0 = ~bufferColl0[rand(~bufferColl0.size)];
		var filename1 = ~bufferColl1[rand(~bufferColl1.size)];
		var input = filename0 ++ "\"" + "\"" ++ filename1, count="4", cutoff="10000";
		filename0 = filename0.replace("/", "_");
		filename1 = filename1.replace("/", "_");

		output= ~outPath++filename0++"_inb_"++filename1;
		~cdp.value("submix inbetween2", input, output, count + cutoff);
	}
}).start;
)



////// Arranging & Transferring the orginal wav files to make gestures//////


/////1

(
~recordBus1 = Bus.audio(s, 4);
~rec1 = Record("/Works_S/Sounds/trk1.wav", ~recordBus1, 4);
~recordBus2 = Bus.audio(s, 4);
~rec2 = Record("/Works_S/Sounds/trk2.wav", ~recordBus2, 4);
~recordBus3 = Bus.audio(s, 4);
~rec3 = Record("/Works_S/Sounds/trk3.wav", ~recordBus3, 4);
~recordBus4 = Bus.audio(s, 4);
~rec4 = Record("/Works_S/Sounds/trk4.wav", ~recordBus4, 4);
~recordBus5 = Bus.audio(s, 4);
~rec5 = Record("/Works_S/Sounds/trk5.wav", ~recordBus5, 4);

{
~rec1.start; ~rec2.start; ~rec3.start; ~rec4.start; ~rec5.start;
}.defer(0.1);

~shortPath = "/Works_S/Sounds/SCPoint/Short/eqd/";
~bufferColl4 = List.newClear(0);
~bufferColl4 = (~shortPath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};
~frictionBuffer = ~bufferColl4;


~frictioned= Task({
var index = 0;
var brownRate = 4;
var fade = -1;
var mass, spring, damp, friction, waitF, panTime;

	~wait = [1, 1, 2, 3, 5];

	200.do{ |i|
		b = ~frictionBuffer.choose;

		if(i==14, {~wait = ~wait/1.8;});

		if(i==24, {~wait = ~wait/4;});

		if(i==36, {~wait = ~wait*4;});

		if(i==45, {~wait = ~wait/3;});

		if(i==110, {~wait = ~wait/2;});

		friction = 0.006.rand;
		spring = 20.rand;
		damp = 4.rand;
		mass = 2.1.rand;
		waitF = ~wait.choose;

SynthDef(\warp, {|buffer|
			var chain;
			var env = EnvGen.ar(Env.perc(0.04.rand, waitF*(4+4.rand)), 1);
			var schime = 3*PlayBuf.ar(1, b, 0.8+1.0.rand, 1, startPos: 0.05.rand, doneAction: 2);
			var out = 2.5*Friction.ar(schime, 0.001+friction, spring:1+spring, damp: 0.8+damp, mass: 5.6+mass);

			out = PitchShift.ar(out, 0.5, 0.5+1.7.rand, 0.04, 0.2, 1);
			out = HPF.ar(out, 70);
			panTime = rrand(0.8,1.6);
			if(index % 4 == 0, {
				out = Pan4.ar(out, Line.kr(-1, 1, panTime), 1);});
			if(index % 4 == 1, {
				out = Pan4.ar(out, 1, Line.kr(1, -1, panTime))});
			if(index % 4 == 2, {
				out = Pan4.ar(out, Line.kr(1, -1, panTime), -1)});
			if(index % 4 == 3, {
				out = Pan4.ar(out, -1, Line.kr(-1, 1, panTime))});



			Out.ar(~recordBus1, env*out);
}).play;


		~info = ("{"++index.asString++","+waitF.asString ++","+panTime.round(0.001).asString++","+friction.round(0.001).asString++","+spring.round(0.001).asString++","+damp.round(0.001).asString++","+mass.round(0.001).asString++"}, \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seq2Data.txt","a");
		f.write(~info);
		f.close;

		index = index+1;
		waitF.wait;
	}
});

~frictioned2 = Task({
var index = 0;
var brownRate = 4;
var fade = -1;
var mass, spring, damp, friction, waitF, panTime;

	~wait = [1, 1, 2, 3, 5];

	200.do{ |i|
		b = ~frictionBuffer.choose;

		if(i==14, {~wait = ~wait/1.8;});

		if(i==24, {~wait = ~wait/4;});

		if(i==36, {~wait = ~wait*4;});

		if(i==45, {~wait = ~wait/3;});

		if(i==110, {~wait = ~wait/2;});

		friction = 0.006.rand;
		spring = 30.rand;
		damp = 3.rand;
		mass = 2.1.rand;
		waitF = ~wait.choose;

SynthDef(\warp, {|buffer|
			var chain;
			var env = EnvGen.ar(Env.perc(0.04.rand, waitF*(4+4.rand)), 1);
			var schime = 3*PlayBuf.ar(1, b, 0.8+1.0.rand, 1, startPos: 0.05.rand, doneAction: 2);
			var out = 2.5*Friction.ar(schime, 0.001+friction, spring:1+spring, damp: 0.8+damp, mass: 8.6+mass);

			out = PitchShift.ar(out, 0.5, 0.5+1.7.rand, 0.04, 0.2, 1);
			out = HPF.ar(out, 70);
			panTime = rrand(0.8,1.6);
			if(index % 4 == 0, {
				out = Pan4.ar(out, Line.kr(-1, 1, panTime), 1);});
			if(index % 4 == 1, {
				out = Pan4.ar(out, 1, Line.kr(1, -1, panTime))});
			if(index % 4 == 2, {
				out = Pan4.ar(out, Line.kr(1, -1, panTime), -1)});
			if(index % 4 == 3, {
				out = Pan4.ar(out, -1, Line.kr(-1, 1, panTime))});



			Out.ar(~recordBus3, env*out);
}).play;


		~info = ("{"++index.asString++","+waitF.asString ++","+panTime.round(0.001).asString++","+friction.round(0.001).asString++","+spring.round(0.001).asString++","+damp.round(0.001).asString++","+mass.round(0.001).asString++"}, \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seq3Data.txt","a");
		f.write(~info);
		f.close;

		index = index+1;
		waitF.wait;
	}
});

~scLongPath = "/Works_S/Sounds/SCPoint/Long/";
~scShortPath = "/Works_S/Sounds/SCPoint/Short/eqd/";
~scPlanePath = "/Works_S/Sounds/SCPlane/";
~scLinePath = "/Works_S/Sounds/SCLine/";
~fragPath = "/Works_S/Sounds/SCPoint/Frag/";
~bufferColl3 = List.newClear(0);
~bufferColl5 = List.newClear(0);
~bufferColl6 = List.newClear(0);
~bufferColl7 = List.newClear(0);
~bufferColl8 = List.newClear(0);
~bufferColl3 = (~fragPath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};
~bufferColl5 = (~scShortPath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};
~bufferColl6 = (~scLongPath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};
~bufferColl7 = (~scLinePath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};
~bufferColl8= (~scPlanePath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};

~readPath = "/Works_S/Sounds/SCPlane/";
~bufferColl2 = List.newClear(0);
~bufferColl2 = (~readPath++"*").pathMatch.collect{ arg path; Buffer.read(s, path)};

SynthDef(\at0, {
	arg gate = 1;
	   var trate = 100, amp = 0.2, stretch = rrand(2, 15), sig;
		var trigger = Impulse.kr(trate);
	var env = EnvGen.ar(Env.asr(0.01, 1, 1), gate, doneAction: 2);
	var gDuration = rrand(0.05, 0.4);
	    sig = 0.1666*Mix.fill(6,{
	      	b = ~bufferColl2.choose;
			env* TGrains.ar(4,trigger, b.bufnum, 1,
			SinOsc.kr((BufDur.kr(b.bufnum) * stretch).reciprocal, mul: BufDur.kr(b.bufnum) + 0.4.rand)
			+ TRand.kr(0,0.01,trigger),
			gDuration,Line.kr([-1, 1, -0.5, 0.5].choose,[-1, 1, -0.5, 0.5].choose, BufDur.kr(b.bufnum) * stretch * rrand(0.4, 1)),amp,1);
	});
	Out.ar(~recordBus2, sig);
}).send(s);

 SynthDef(\at1, {
	arg gate = 1;
	var trigger = Dust.kr(rrand(5,30));
	var env = EnvGen.ar(Env.asr(0.01, 1, 1), gate, doneAction: 2);
	b =  ~bufferColl2.choose;
	    Out.ar(~recordBus3,  env*0.25*Mix.fill(5,{
			TGrains.ar(4, Impulse.kr(TRand.kr(10, 100, trigger)),
			b.bufnum, 1,TRand.kr(0,1,trigger)
			* BufDur.kr(b.bufnum),0.1,TRand.kr(-1,1,trigger), 0.2, 1);
	}));
}).send(s);

SynthDef(\at2, {
	arg gate = 1;
	var stretch = 10;
		var trigger = Dust.kr(30.rand);
	var env = EnvGen.ar(Env.asr(0.01, 1, 1), gate, doneAction: 2);
	b =  ~bufferColl2.choose;

	Out.ar(~recordBus4, env*0.25*Mix.fill(5,{
			TGrains.ar(4, Impulse.kr(TRand.kr(10, 100, trigger)),
			b.bufnum, 1,SinOsc.kr((BufDur.kr(b.bufnum) *stretch).reciprocal, mul: BufDur.kr(b.bufnum) + 0.4.rand)
			* BufDur.kr(b.bufnum),0.1,Line.kr([-1, 1, -0.5, 0.5].choose,[-1, 1, -0.5, 0.5].choose, BufDur.kr(b.bufnum) * stretch * rrand(0.4, 1)), 0.2, 1);
	}));
}).send(s);

)



///////////Run


(
var totalLength = 0;
var bufIndex = 0;
var startFib = Pseq([4, 4, 8, 12, 0], 1).asStream;
var baseFib = Pseq([3.5, 3.5, 7, 10.5, 17.5], 1).asStream;
var finSeqCounter = 0;
~fib = 17.fib/1.4;
~currentBufColl = ~bufferColl3;
~frictionBuffer = ~bufferColl4;

Task({
5.do{ |i|
		var px, py;
		{
					var sig;
			sig = EnvGen.ar(Env.perc(0.08.rand, 25), 1) * MoogFF.ar(HPF.ar(PlayBuf.ar(1, ~bufferColl6[0], 1, 1, 0.08 .rand, doneAction: 2), 30), rrand(4000,18000));

			if(i ==0, {px = -1; py = 1});
			if(i ==1, {px = 1; py = 1});
			if(i ==2, {px = 1; py = -1});
			if(i ==3, {px = -1; py = -1});
			if(i ==4, {px = 0; py = 0});

			Out.ar(~recordBus5, 2 * Pan4.ar(sig, px,  py));
					}.play;

		startFib.next.wait;

	};


	5.do{

Task({
	var index =16, panXRan, panYRan, bpfQrand, sig, counter, currentLength = 0, panX, panY, wipe, width;
	counter = finSeqCounter;

			//194 = 649
	154.do {
		panXRan = 1.0.exprand(0.001) -0.5*2;
		// ifdef 4channel Ver.
		panYRan = 1.0.exprand(0.001) -0.5*2;

				panX = [panXRan, panXRan.abs].choose;
				panY =  [panYRan, panYRan.abs].choose;
				currentLength = (~fib[index]*0.01);

				//Arrays: Sequence (0-4), beat (how many beats passed in each sequences), time(the time until next beat)
				~info = ("{"++totalLength.asString++","+counter.asString ++","+(currentLength).asString++","+panX.round(0.001).asString++","+panY.round(0.001).asString++"}, \n");
				~info.post;
				f = File("/Works_S/Sounds/"++"seqData.txt","a");
				f.write(~info);
				f.close;


				if(totalLength < 229, { ~currentBufColl = [~bufferColl3[bufIndex], ~bufferColl3[bufIndex+1], ~bufferColl3[bufIndex+2]]});
				if(totalLength == 229, {~fib = ~fib*1.5; ~currentBufColl = ~bufferColl5});

				if(totalLength == 305, {~frictioned.start(TempoClock(1.5)); 40.wait; ~frictionBuffer = ~bufferColl7 ++ ~bufferColl3; 20.wait;});

				///////////?원래 60
				if(totalLength == 306, {40.wait;});
				if(totalLength == 307, {60.wait;});
				if(totalLength == 308, {60.wait;});
				// if(totalLength == 579, { 60.wait;});

				if(totalLength == 309, {~fib = ~fib/4; ~currentBufColl = ~bufferColl7});
				if((totalLength < 334) , { wipe = 0.05*counter+(totalLength/3000); width = 0.05*counter+(totalLength/3000)});
				if(totalLength == 334, {~fib = ~fib*2; wipe = 0; width = 0});
				if(totalLength == 452, {~fib = ~fib/2; ~currentBufColl = ~bufferColl6 ++ ~bufferColl7; ~frictioned.pause});
				if((totalLength > 475) , { wipe = 0.05*counter+(totalLength/4000); width = 0.05*counter+(totalLength/4000)});
				if(totalLength == 535, {~fib = ~fib*2; ~currentBufColl = ~bufferColl7++~bufferColl8});
				if(totalLength == 600, {~fib = ~fib/1.4; ~currentBufColl = ~bufferColl8});

			if(totalLength < 334, 	{{
					var sig;
					sig = EnvGen.ar(Env.perc(0.05.rand, 25), 1) * MoogFF.ar(HPF.ar(PlayBuf.ar(1, ~currentBufColl.choose, rrand(0.6, 2.5), 1, 0.08 .rand, doneAction: 2), 30), 15000);
					sig = FFT(LocalBuf(4096), sig);
					sig = PV_BinScramble(sig, wipe: wipe, width: width, trig: Dust.kr(counter*4));
					sig = IFFT(sig);
					Out.ar(~recordBus5, 1.5 * Pan4.ar(sig, panX,  panY));
				}.play});

				if((totalLength >= 334) && (totalLength < 535), 	{{
					var sig;
					sig = EnvGen.ar(Env.perc(0.05.rand, 25), 1) * MoogFF.ar(HPF.ar(PlayBuf.ar(1, ~currentBufColl.choose, rrand(0.6, 2.5), 1, 0.08 .rand, doneAction: 2), 30), 15000);

					Out.ar(~recordBus5, 1.5 * Pan4.ar(sig, EnvGen.ar(Env.triangle(2*panX.abs))-0.5*2, -1*(EnvGen.ar(Env.triangle(2*panY.abs))-0.5*2)));
				}.play});

				if((totalLength >= 535) && (totalLength < 600), 	{{
					var sig;
					sig = EnvGen.ar(Env.perc(0.05.rand, 25), 1) * MoogFF.ar(HPF.ar(PlayBuf.ar(1, ~currentBufColl.choose, rrand(0.6, 2.5), 1, 0.08 .rand, doneAction: 2), 30), 15000);
					sig = FFT(LocalBuf(4096), sig);
					sig = PV_BinScramble(sig, wipe: wipe, width: width, trig: Dust.kr(counter*4));
					sig = IFFT(sig);
					Out.ar(~recordBus5, 1.5 * Pan4.ar(sig, SinOsc.kr(panX.abs, [3*pi/4, pi/4].choose),  SinOsc.kr(panY.abs, [3*pi/4, pi/4].choose)));
				}.play});



		(~fib[index]*0.01).wait;

				if((index <17) && (index >0), {index = index-1; });
		if(index == 0, {index = 16});
		bufIndex = bufIndex+3;


				if(totalLength % 130 == 0, {bufIndex = 0; ~fib = ~fib.reverse; ~fib.add(17); ~fib.add(277);});


				totalLength = totalLength+1;

		0.01.wait;

			}
}).start;
	baseFib.next.wait;
	finSeqCounter = finSeqCounter+1;
	};


	1.do{
	280.wait;

		~info = ("end 400 sec wait.... \n \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seqData.txt","a");
		f.write(~info);
		f.close;

	};


	1.do{
		var waitT;
		waitT = 30.rand;
		~har1 = Synth(\at1);

		~info = ("at1Synth.."+waitT.asString++"sec wait \n \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seqData.txt","a");
		f.write(~info);
		f.close;

		waitT.wait;

		1.wait;
	};

		1.do{
		var waitT = 30.rand;

		~har2 =   Synth(\at2);

		~info = ("at1, 2Synth.."+waitT.asString++"sec wait \n \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seqData.txt","a");
		f.write(~info);
		f.close;

		waitT.wait;

		1.wait;
	};

		1.do{
		var waitT = rrand(20, 40);

		~har3 = Synth(\at0);


		~info = ("at0 Synth.."+waitT.asString++"\n \n");
		~info.post;
		f = File("/Works_S/Sounds/"++"seqData.txt","a");
		f.write(~info);
		f.close;

		waitT.wait;

		~har1.release;
		~har2.release;
		~har3.release;
		1.wait;

	};


////
	5.do{ |i|

		if(i == 0, {
		finSeqCounter = 0;
		baseFib = Pseq([3.5, 3.5, 7, 10.5, 17.5], 1).asStream;
		});

		~fib = 17.fib/6;

Task({
	var index =16, panXRan, panYRan, bpfQrand, sig, counter, currentLength = 0, panX, panY, wipe, width, indexTotal;
	counter = finSeqCounter;

			~frictionBuffer = ~bufferColl8;
			indexTotal = index;

	480.do {
		panXRan = 1.0.exprand(0.001) -0.5*2;
		// ifdef 4channel Ver.
		panYRan = 1.0.exprand(0.001) -0.5*2;

				panX = [panXRan, panXRan.abs].choose;
				panY =  [panYRan, panYRan.abs].choose;
				currentLength = (~fib[index]*0.01);

				//Arrays: Sequence (0-4), beat (how many beats passed in each sequences), time(the time until next beat)
				~info = ("{"++totalLength.asString++","+counter.asString ++","+(currentLength).asString++","+panX.round(0.001).asString++","+panY.round(0.001).asString++"}, \n");
				~info.post;
				f = File("/Works_S/Sounds/"++"seqData.txt","a");
				f.write(~info);
				f.close;


				wipe = 0.05*counter+(totalLength/3000); width = 0.05*counter+(totalLength/3000);

				~currentBufColl = ~bufferColl6++~bufferColl7;


		/*			if(totalLength  == 1190, {
					~har4.pause;
				});
*/

				if(totalLength  == 847, {
					~frictioned.start(TempoClock(3));
					~frictioned2.start(TempoClock(1));


				});


				if(totalLength == 900 , {
				SynthDef(\at0, {
					arg gate = 1;
							   var trate = 100, amp = 0.2, stretch = 2.5, sig;
						var trigger = Impulse.kr(trate);
						var env = EnvGen.ar(Env.asr(0.01, 1, 1), gate, doneAction: 2);
						var gDuration = rrand(0.05, 0.4);
						sig = 0.1666*Mix.fill(6,{
							b = ~bufferColl2.choose;
							env* TGrains.ar(4,trigger, b.bufnum, 0.6,
								SinOsc.kr((BufDur.kr(b.bufnum) * stretch).reciprocal, mul: BufDur.kr(b.bufnum) + 0.4.rand)
								+ TRand.kr(0,0.01,trigger),
								gDuration,Line.kr([-1, 1, -0.5, 0.5].choose,[-1, 1, -0.5, 0.5].choose, BufDur.kr(b.bufnum) * stretch * rrand(0.4, 1)),amp,1);
						});
						Out.ar(~recordBus2, sig);
					}).send(s);
					~har4 = Synth(\at0);
				});

				{
					var sig;
					sig = EnvGen.ar(Env.perc(0.05.rand, 25), 1) * MoogFF.ar(HPF.ar(PlayBuf.ar(1, ~currentBufColl.choose, rrand(0.6, 2.5), 1, 0.08 .rand, doneAction: 2), 30), 15000);
					sig = FFT(LocalBuf(4096), sig);
					sig = PV_BinScramble(sig, wipe: wipe, width: width, trig: Dust.kr(counter*4));
					sig = IFFT(sig);
					Out.ar(~recordBus5, 1.5 * Pan4.ar(sig, SinOsc.kr((panX*2).abs, [3*pi/4, pi/4].choose),  SinOsc.kr(panY.abs, [3*pi/4, pi/4].choose)));
				}.play;



		(~fib[index]*0.01).wait;

				if((index <17) && (index >0), {index = index-1; });
				if(index == 0, {index = indexTotal});

				if(totalLength % 120 == 0, {~fib = ~fib.reverse; ~fib.pop; indexTotal = indexTotal-1});


				totalLength = totalLength+1;

		0.01.wait;


	}
}).start;
	baseFib.next.wait;
	finSeqCounter = finSeqCounter+1;
	};


}).start;
)


///end of code
