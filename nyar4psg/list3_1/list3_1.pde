
/*  リスト3.1 最も簡単なARのプログラム */

import jp.nyatla.nyar4psg.*;  // NyAR4psg
import processing.video.*;    // ビデオライブラリ

Capture cam;    // キャプチャ
MultiMarker ar; // ARマーカに関する処理をするオブジェクト
int id;         // マーカに割り当てられるID番号

void setup() {
  size(640,480,P3D); // 画面の設定
  cam = new Capture(this, width, height); // キャプチャの準備
  
  // ARをやるための準備
  ar = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  id = ar.addARMarker("patt.hiro", 60); // パターンファイルとマーカサイズの登録
}

void draw() {
  // カメラの用意ができていないときは処理をせずに出る
  if (cam.available()==false) return;

  cam.read();             // カメラ画像の読み込み
  background(0);          // 画面の初期化
  ar.drawBackground(cam); // 背景画像の描画
  ar.detect(cam);         // マーカ認識

  // マーカが認識されていたら
  if ( ar.isExist(id) ) {
    ar.beginTransform(id);
    fill(116,163,241,100); // 立方体の色
    translate(0,0,15);     // 立方体をマーカ上に載せるために上方向に移動
    box(30);               // 一辺が30mmの立方体を描画
    ar.endTransform();
  }
}