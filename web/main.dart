/*
The MIT License (MIT)

Copyright (c) 2014 Andrew O'Neill

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
