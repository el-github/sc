s.boot;

//low pass filter
{ [LPF.ar(WhiteNoise.ar(0.5), Line.kr(10000,1000,10)), LPF.ar(WhiteNoise.ar(0.5), Line.kr(1000,10000,10))] }.play;

{[Resonz.ar(LFNoise0.ar(400),1000,0.1),Resonz.ar(LFNoise0.ar(400),1000,0.1)]}.play;

//Additive synth
{Pan2.ar(Mix(SinOsc.ar([400,660],0,0.1)), 0)}.scope;

//Ring modulation
(
{
var carrier, modulator, carrfreq, modfreq;
carrfreq= MouseX.kr(440,5000,'exponential');
modfreq= MouseY.kr(1,5000,'exponential');
carrier= SinOsc.ar(carrfreq,0,0.5);
modulator= SinOsc.ar(modfreq,0,0.5);
Pan2.ar(carrier*modulator, 0);
}.scope;
)

//AM
(
{
var carrier, modulator, carrfreq, modfreq;
carrfreq= MouseX.kr(440,5000,'exponential');
modfreq= MouseY.kr(1,5000,'exponential');
carrier= SinOsc.ar(carrfreq,0,0.5);
modulator= SinOsc.ar(modfreq,0,0.25, 0.25);
Pan2.ar(carrier*modulator, 0);
}.scope;
)

//FM
(
{arg carrfreq=440, modfreq=50, moddepth=50.1;
Pan2.ar(SinOsc.ar(carrfreq + (moddepth*SinOsc.ar(modfreq)),0,0.25));
}.scope;
)

Env([0,1,0],[1.0,0.5]).plot;  //one second 0 to 1 then half a second 1 to 0
Env.linen(0.03,0.5,0.1).plot;  //linen has attackTime, sustainTime, releaseTime, level, curve
Env.adsr(0.01, 0.5, 0.5, 0.1, 1.0, 0).plot;  //attackTime, decayTime, sustainLevel, releaseTime, peakLevel, curve
Env.perc(0.05,0.5,1.0,-2).plot; //arguments attackTime, releaseTime, level, curve: good for percussive hit envelopes

//kick
(
{
	Pan2.ar(SinOsc.ar(80,0,0.1)*EnvGen.kr(Env.perc(0.01,0.4,1.0,1)), 0);
}.scope;
)

//Band Limited ImPulse
(
{Pan2.ar(Blip.ar(440, 200, 0.5, 0));}.scope;
)


s.quit;