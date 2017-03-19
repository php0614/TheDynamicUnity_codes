//stoneChime Physical models visualization, Philip Liu 2017

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

ofBackground(0);
mesh.setMode(OF_PRIMITIVE_POINTS);
mesh2.setMode(OF_PRIMITIVE_POINTS);


////frags
//for(int i=0; i<47; i++){
//   tmpArr.push_back(new t_shape(*calcMesh(3, 0, i)));
//}

////stoneChimes
///
for(int i=2; i<15; i=i+4){
   tmpArr.push_back(new t_shape(*calcMesh(2, i, 0)));
}


}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    int magnifyMesh = 10;

//    for(int o = 2; o<=14; o=o+4){

    int fragCount = ofGetFrameNum()/5;

    t_shape *tmpShp;


    ////frags
    // for(int j = 5; j<47; j++){

    ////stoneChimes
    for(int j = 0; j<4; j++){
    tmpShp = tmpArr[j];


    ofPushMatrix();

    ////frags
//    int translateRow = 100+((j-5)*180);

//    int translateColumn;
//    if(translateRow < ofGetWidth()-90){
//      ofTranslate(translateRow, ofGetHeight()/4);
//    }else if(translateRow < 2*(ofGetWidth()-80) && translateRow >= ofGetWidth()-90){
//       ofTranslate(translateRow-ofGetWidth()+90, 2*ofGetHeight()/4);
//    } else{
//       ofTranslate(translateRow-(2*ofGetWidth()), 3*ofGetHeight()/4);
//    }

    ////stoneChime
    int translateRow = (ofGetWidth()/2)-800 +(j*400);
    ofTranslate(translateRow, ofGetHeight()/2);



    float size = 0;


    /////////Tension! 0.02~0.5. same as ideal range of tension in StoneChime UGEN in SC
    float tension = 0.02;
    tension = ofMap(tension, 0.02, 0.5, 1, 18);



        for(int i = 0; i<tmpShp->lines_n; i++){
            ofPoint p1 = ofPoint(magnifyMesh*tmpShp->lines[i]->a->x, sqrt(2)*magnifyMesh*tmpShp->lines[i]->a->y);
            ofPoint p2 = ofPoint(magnifyMesh*tmpShp->lines[i]->b->x, sqrt(2)*magnifyMesh*tmpShp->lines[i]->b->y);
            ofPoint middle1 = (p1+p2)/2;

            mesh.addVertex(p1);
            mesh.addVertex((p1+middle1)/2);
            mesh.addVertex(middle1);
            mesh.addVertex((p2+middle1)/2);
            mesh.addVertex(p2);
    }

        for(int i = ((int)tension*10); i<mesh.getNumVertices()-5; i=i+1){
            if((int)i % (int)tension == 0){
            mesh2.addVertex((mesh.getVertex(i) + mesh.getVertex(i+1))/2);
            mesh2.addVertex((mesh.getVertex(i+1) + mesh.getVertex(i+2))/2);
            mesh2.addVertex((mesh.getVertex(i+2) + mesh.getVertex(i+3))/2);
            mesh2.addVertex((mesh.getVertex(i+3) + mesh.getVertex(i+4))/2);
            }
        }

        mesh.draw();
        mesh2.draw();

        ofPushMatrix();
        ofTranslate(1,1);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        ofPushMatrix();
        ofTranslate(-1,-1);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        ofPushMatrix();
        ofTranslate(1,0);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        ofPushMatrix();
        ofTranslate(-1,0);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        ofPushMatrix();
        ofTranslate(0,1);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        ofPushMatrix();
        ofTranslate(0,-1);
        mesh.draw();
        mesh2.draw();
        ofPopMatrix();

        mesh.clear();
        mesh2.clear();

        ofPopMatrix();

    }
//    ofSaveScreen("stoneChimes.png");
}
//}

//--------------------------------------------------------------
