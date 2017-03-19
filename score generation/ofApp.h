#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

public:
    void setup();
    void update();
    void draw();


    ofImage img;
    ofSoundPlayer sample;

    float 				* fftSmoothed;
    int nBandsToGet;


};
