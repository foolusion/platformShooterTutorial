import 'dart:html';

void main() {
  // get the canvas element from the web page.
  CanvasElement canvas = querySelector('#game');
  // change the default canvas size
  canvas.width = 640;
  canvas.height = 480;
  // get the rendering context from the canvas
  CanvasRenderingContext2D ctx = canvas.context2D;
  
  // draw a red and blue square on the canvas
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = 'rgb(255,0,0)';
  ctx.fillRect(128, 128, 256, 256);
  ctx.fillStyle = 'rgba(0, 0, 255, .7)';
  ctx.fillRect(0, 0, 256, 256);
}