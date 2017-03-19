#pragma once

#include "ofMain.h"
//#include "Membrane_shape.h"
//#include "PyeonGyeong.h"
#include "stonechime.h"

class ofApp : public ofBaseApp{

public:
    void setup();
    void update();
    void draw();

    ofMesh mesh;
    ofMesh mesh2;

    vector<t_shape*> tmpArr;

};
