#include "ofApp.h"
//#include "sequencedata.h"
//#include "seq2data.h"

//--------------------------------------------------------------
void ofApp::setup(){

   ofBackground(0);
   ofNoFill();
   ofSetLineWidth(1.5);
   ofEnableSmoothing();
   ofSetFrameRate(30);

   ////sonogram picture load
//   img.load("sono2880.jpg");

////FFT
   sample.load("dus.wav");
   sample.play();

   fftSmoothed = new float[4096];
   for (int i = 0; i < 4096; i++){
       fftSmoothed[i] = 0;
   }

   nBandsToGet = 2800;




}

//--------------------------------------------------------------
void ofApp::update(){

////fft
ofSoundUpdate();
sample.setPosition((ofGetFrameNum()/30.0)/497.6061);
float * val = ofSoundGetSpectrum(nBandsToGet);
for (int i = 0;i < nBandsToGet; i++){

    fftSmoothed[i] *= 0.96f;
    if (fftSmoothed[i] < val[i]) fftSmoothed[i] = val[i];
}

}

//--------------------------------------------------------------
void ofApp::draw(){

    //3. drawing final interactive score

//    img.draw(0, 0);

//    float elapsedTime = ofGetFrameNum()/30.0;

//    ofDrawLine(ofMap(elapsedTime, 0, 497.6061, 0, 2753)+2, 0, ofMap(elapsedTime, 0, 497.6061, 0, 2753)+2, ofGetHeight());



    //4. fft visualizer drawing
   int rotatePolarModulo = ((ofGetFrameNum()%500) /500.0) * 10;
    for (int i = 0;i < 400; i++){

        ofPushStyle();

//        ofSetColor(ofClamp(fftSmoothed[i]* (i*i)/nBandsToGet * 30.0, 0, 240));
        ofSetColor(ofClamp(fftSmoothed[i] * 1400.0, 0, 240));
        ofDrawLine(i*(2800/(nBandsToGet)), (ofGetHeight()-200), i*(2800/(nBandsToGet)), ofGetHeight());

        ofPopStyle();
    }




//    1. sequence1 score visualize

//    float widthMul = 9.1;

//    for(int j = 0; j<4; j++){
//        float positionData;
//        int verticalPosition = 0;
//        float seq0Time = 0,seq1Time = 3.5*widthMul,seq2Time = 3.5*widthMul,seq3Time = 7*widthMul, seq4Time = 10.5*widthMul;
//    for(int i = 0; i<636; i++){
//        if(j == 0){ //front Left Speaker
//              positionData = 64*((1-seqData[i][3])+(1+seqData[i][4])); verticalPosition = 0;
//        }
//        if(j == 1){ //front Right Speaker
//              positionData = 64*((1+seqData[i][3])+(1+seqData[i][4])); verticalPosition = ofGetHeight()/4;
//        }
//        if(j == 2){ //Rear Left Speaker
//              positionData = 64*((1-seqData[i][3])+(1-seqData[i][4])); verticalPosition = ofGetHeight()/4*2;
//        }
//        if(j == 3){ //Rear Right Speaker
//              positionData = 64*((1+seqData[i][3])+(1-seqData[i][4])); verticalPosition = ofGetHeight()/4*3;
//        }

//        if(seqData[i][1] == 0){
//             ofSetColor(210,35,10, positionData);
//             ofDrawLine(seq0Time, verticalPosition, seq0Time, verticalPosition+(ofGetHeight()/20));
//             seq0Time += (widthMul*seqData[i][2]);
//        }

//        if(seqData[i][1] == 1){
//             ofSetColor(15,230,10, positionData);
//             ofDrawLine(seq1Time, verticalPosition+(ofGetHeight()/20), seq1Time, verticalPosition+(ofGetHeight()/10));
//             seq1Time += (widthMul*seqData[i][2]);
//        }

//        if(seqData[i][1] == 2){
//             ofSetColor(40,5,210, positionData);
//             ofDrawLine(seq2Time, verticalPosition+(ofGetHeight()/10), seq2Time, verticalPosition+(3*ofGetHeight()/20));
//             seq2Time += (widthMul*seqData[i][2]);
//        }

//        if(seqData[i][1] == 3){
//             ofSetColor(180,180,180, positionData);
//             ofDrawLine(seq3Time, verticalPosition+(3*ofGetHeight()/20), seq3Time, verticalPosition+(4*ofGetHeight()/20));
//             seq3Time += (widthMul*seqData[i][2]);
//        }

//        if(seqData[i][1] == 4){
//             ofSetColor(150,110,0, positionData);
//             ofDrawLine(seq4Time, verticalPosition+(4*ofGetHeight()/20), seq4Time, verticalPosition+(ofGetHeight()/4));
//             seq4Time += (widthMul*seqData[i][2]);
//        }

//    }
//    }





//    2. sequence2 score visualize

//    float widthMul =4;
//    float verticalPosition = 0;
//    float seqTime = 0;
//    float currentSeqTime = 0;
//        for(int i = 0; i<200; i++){

//            if(i%4 == 0){
//                verticalPosition = 0;
//                ofSetColor(210,35,10, ofMap((seq2Data[i][2]-0.8), 0, 1.0, 100, 255));
//            }
//            if(i%4 == 1){
//                verticalPosition = ofGetHeight()/4;
//                ofSetColor(15,200,40,ofMap((seq2Data[i][2]-0.8), 0, 1.0, 100, 255));
//            }
//            if(i%4 == 2){
//                verticalPosition = ofGetHeight()/4*2;
//                ofSetColor(60,5,190, ofMap((seq2Data[i][2]-0.8), 0, 1.0, 100, 255));
//            }
//            if(i%4 == 3){
//                verticalPosition = ofGetHeight()/4*3;
//                ofSetColor(127,100,27, ofMap((seq2Data[i][2]-0.8), 0, 1.0, 100, 255));
//            }


//            ofPushMatrix();
//            ofTranslate(100, 0);
//            ofDrawBezier(currentSeqTime+4, verticalPosition,
//                        (currentSeqTime+4)-(300*seq2Data[i][3]), verticalPosition-(seq2Data[i][5]),

//                        (currentSeqTime+4)+(4*seq2Data[i][4]), verticalPosition+(ofGetHeight()/4)+(3*seq2Data[i][6]),
//                     currentSeqTime+4, verticalPosition + (ofGetHeight()/4)
//                    );


//            if(i%4 == 0){
//                verticalPosition = 0;
//                ofSetColor(210,35,10, (1.8-seq2Data[i][2]) * 120);
//            }
//            if(i%4 == 1){
//                verticalPosition = ofGetHeight()/4;
//                ofSetColor(15,200,40, (1.8-seq2Data[i][2]) * 120);
//            }
//            if(i%4 == 2){
//                verticalPosition = ofGetHeight()/4*2;
//                ofSetColor(60,5,190, (1.8-seq2Data[i][2]) * 120);
//            }
//            if(i%4 == 3){
//                verticalPosition = ofGetHeight()/4*3;
//                ofSetColor(127,100,27, (1.8-seq2Data[i][2]) * 120);
//            }


//           if(i%4 == 3){
//               ofDrawBezier(
//                           currentSeqTime+4, 0,
//                           currentSeqTime+4-(300*seq2Data[i][3]), 0-(seq2Data[i][5]),

//                           currentSeqTime+4+(4*seq2Data[i][4]), 0+(ofGetHeight()/4)+(3*seq2Data[i][6]),
//                       currentSeqTime+4, (ofGetHeight()/4)
//                       );
//            }else{

//            ofDrawBezier(
//                        currentSeqTime+4, verticalPosition + (ofGetHeight()/4),
//                        currentSeqTime+4-(300*seq2Data[i][3]), verticalPosition-(seq2Data[i][5])+ (ofGetHeight()/4),

//                        currentSeqTime+4+(4*seq2Data[i][4]), verticalPosition+(ofGetHeight()/2)+(3*seq2Data[i][6]),
//                    currentSeqTime+4, verticalPosition + (ofGetHeight()/4) + (ofGetHeight()/4)
//                    );
//        }
//           ofPopMatrix();


//            seqTime += (seq2Data[i][1]);
//            currentSeqTime = seqTime * widthMul;


//        }


    ////interactive and fft video
//    ofSaveScreen("score/"+ofToString(ofGetFrameNum())+".png");
      ofSaveScreen("fft2/"+ofToString(ofGetFrameNum())+".png");

    ////score generation, sequence 1,2,3
    //ofSaveScreen("secondfirst.png");

}

