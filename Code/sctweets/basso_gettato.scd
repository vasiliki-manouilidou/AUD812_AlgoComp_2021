//: 26 Nov 2020 13:54
// «"basso gettato" sctweet autopsy» by zepadovani
// from: http://sccode.org/1-4Zx

//Some people have asked me to explain my sctweet "basso gettato" published in the web-album "SC140" by The Wire by an initiative of Dan Stowell. (http://supercollider.github.io/community/sc140.html)

//Here is my attempt to explain the code:

//original sctweet
play{x=165;b=SinOsc;p=Trig.ar(Saw.ar(x),1);y=b.ar(p*x);z=b.ar(p);(GVerb.ar(GrainIn.ar(2,y,y/2,z,p*z,-1),9))/9}//basso gettato #SuperCollider

//p
//creates a "nice series" of numbers above 0 and below 1 with the duration of 1 second
{Saw.ar(165)}.plot(0.1) //simple sawtooth wave
{Trig.ar(Saw.ar(165),1).poll}.play //get values just after the "above 0" jump
{Trig.ar(Saw.ar(165),1)}.plot(30) //wait 30 seconds, go get a cofee, and come back to see the skyscraper profile of the "nice numbers" generated

//z
//is a variable LFO as it is a SinOsc with frequency argument equal to the current "nice number" generated by p
{SinOsc.ar((Trig.ar(Saw.ar(165),1)).poll)}.play

//y
//is a faster version of z, as the sinusoids have the frequency values generated by the multiplication of p "nice values" and 165
{SinOsc.ar((Trig.ar(Saw.ar(165),1)*165).poll)}.play

//grainin
// creates grains of z at y rate, duration is y/2 and pan of each grain is given by p*z
// althought z itself is not in the audible range, the rate makes the little pulses audible either as a slow rhythm (when y is very low) or as a low note (when y is near 165)
// trigger argument:
GrainIn.ar(2,y,y/2,z,p*z,-1)

//GVerb: well... everything is cooler with GVerb!
{Saw.ar(0.1)}.plot(1)

//A final note: 165 works well because it does not fit to the samplerate / block size values. For example, try to use the value (44100/64) – or any simple ratio of it – instead and you will have something a bit more monotonous