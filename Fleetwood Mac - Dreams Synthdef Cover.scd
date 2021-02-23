s.boot;
// Basic drum kit
(
SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef("snare", {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;

SynthDef("kick", {arg out = 0, amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var env, snd, ramp;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	ramp = XLine.kr(
		start: sinfreq,
		end: sinfreq * glissf,
		dur: rel
	);
	snd = SinOsc.ar(freq: ramp, mul: env);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
}).add;

// Basic saw synth for chords and bass
SynthDef("sawSynth", { arg freq = 440, amp = 0.1, att = 0.1, rel = 2, lofreq = 1000, hifreq = 3000;
    var env, snd;
    env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: amp
	).kr(doneAction: 2);
    snd = Saw.ar(freq: freq * [0.99, 1, 1.001, 1.008], mul: env);
	snd = LPF.ar(
		in: snd,
		freq: LFNoise2.kr(1).range(lofreq, hifreq)
	);
    snd = Splay.ar(snd);
    Out.ar(0, snd);
}).add;

SynthDef("rhodes", { arg freq = 440, amp = 0.1, att = 0.1, rel = 2, lofreq = 1000, hifreq = 3000;
    var env, snd;
    env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: amp
	).kr(doneAction: 2);
    snd = Saw.ar(freq: freq * [0.99, 1, 1.001, 1.008], mul: env);
	snd = LPF.ar(
		in: snd,
		freq: LFNoise2.kr(1).range(lofreq, hifreq)
	);
    snd = Splay.ar(snd);
    Out.ar(0, snd);
}).add;
)




// Drums
(
Pbind(
	\instrument, "hihat",
	\dur, Pseq([2/16], inf),
	\att, 0.01,
	\rel, 0.05,
	\ffreq, 11000,
	\pan, -1,
	\amp, 0.3,
	\tempo, 30/60
).play;




Pbind(
	\instrument, "snare",
	\dur, Pseq([Rest(1/4), 1/4], inf),
	\att, 0.001,
	\rel, 0.1,
	\sinfreq, 200,
	\ffreq, 3000,
	\amp, 0.25

).play;

Pbind(
	\instrument, "kick",
	\dur, Pseq([1/4,1/4,1/4,1/4],inf),
	\att, 0.001,
	\rel, 0.22,
	\sinfreq, 60,
	\glissf, 0.9,
	\amp, 2,
).play;


//Bass

Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([29, 41, 29, 29, 41, 29, 31, 43, 31, 31, 43, 31], inf),
	\dur, Pseq([1/4, 1/8, 1/8, 1/4, 1/8, 1/8], inf),
	\ctranspose, [0, -12],
	\att, 0.03,
	\rel, 0.7,
	\amp, 0.9,
	\rev, 1,
	\lofreq, 100,
	\hifreq, 1000
).play;

//Intro Riff

Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([50, 50, 52, 50, 48, 45, 50, 45, 47, 45, 43, 40, 50, 38, 40, 55, 35, 33], 2),
	\dur, Pseq([Rest(14/4),1/8, 1/8, 1/8, 1/8, 1/1,Rest(2/4),1/8, 1/8, 1/8, 1/8, 1/1, Rest (0.5/4), 1/8, 1/8, 1/4, 1/4, 1/1], 1),
	\ctranspose, [0, 12],
	\att, 0.1,
	\rel, 2,
	\amp, 0.4,
	\rev, 0.9,
	\pan, 0.1,
	\lofreq, 100,
	\hifreq, 1000,
).play;
)
// Verse 1.1

Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([50, 57, 50, 60, 62, 64, 62, 60, 57, 60, 50, 57, 60, 57, 62, 57, 55, 50, 57, 60, 62, 64, 62, 60, 62, 57]+24, 1),
	\dur, Pseq([Rest(1/4), 1/8, Rest (1/8), 1/8, 1/4, 1/4, 1/4, 1/4, 1/8, 1/8, Rest(1.5/4), 1/8, 1/4, 1/8, 1/4, 1/4, 1/4, Rest(3/4), 1/4, 1/8, 1/4, 1/4, 1/4, 1/4, 1/8, 1/4], inf),
	\ctranspose, [0, 12],
	\att, 0.1,
	\rel, 0.9,
	\amp, 0.7,
	\rev, 0.4,
	\lofreq, 100,
	\hifreq, 1000,
).play;

//Verse 1.2

Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([50, 69, 69, 50, 67, 72, 71, 50, 69, 69, 67, 50, 64, 64, 64, 64, 64, 64, 57, 55]+12),
	\dur, Pseq([Rest(1/4), 1/8, 1/8, Rest(1/8),1/8, 1/8, 1/4, Rest(1/8), 1/8, 1/4, 1/4, Rest(1/8), 1/4, 1/8, 1/8, Rest (1/8), 1/4, 1/4, 1/8, 1/4], inf),
	\ctranspose, [0, 12],
	\att, 0.1,
	\rel, 0.9,
	\amp, 1,
	\rev, 0.4,
	\lofreq, 100,
	\hifreq, 1000,
).play;

// Pre-Chorus Riff


Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([53, 57, 60, 57, 55, 59, 62, 59, 57, 60, 67, 60, 55, 59, 65, 59], 3),
	\dur, Pseq([1/4, 1/4, 1/4, 1/4, 1/4, 1/4], inf),
	\ctranspose, [0, 12],
	\att, 0.5,
	\rel, 1.1,
	\amp, 0.4,
	\rev, 2,
	\lofreq, 100,
	\hifreq, 1000,
).play;



//Verse 1.3

Pbind(
	\instrument, "sawSynth",
	\midinote, Pseq([55, 64, 62, 60, 57, 64, 64, 62, 60, 57, 62, 60, 55, 55, 64, 62, 60, 60]+12),
	\dur, Pseq([1/8, 1/8, 1/4, 1/8, 1/8, Rest(1/8), 1/8, 1/4, 1/4, Rest(1/8), 1/4, 1/8, 1/8, Rest (1/8), 1/4, 1/4, 1/8, 1/4], inf),
	\ctranspose, [0, 12],
	\att, 0.1,
	\rel, 0.9,
	\amp, 1,
	\rev, 0.4,
	\lofreq, 100,
	\hifreq, 1000,
).play;

)