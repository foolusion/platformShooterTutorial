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

import 'dart:html' as html;
import 'dart:async' as async;

void main() {
  Game g = new Game();
  g.gameLoop();
}

class Game {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D ctx;
  
  List<String> keys;
  Map<String, bool> actions;
  
  Player p;
  
  int time;
  int wallTime;
  final int maxStep = 15;
  
  Game() {
    canvas = html.querySelector('#game');
    canvas.width = 640;
    canvas.height = 480;
    ctx = canvas.context2D;
    
    keys = new List<String>(256);
    actions = new Map<String, bool>();
    keys[37] = 'left';
    keys[38] = 'up';
    keys[39] = 'right';
    keys[40] = 'down';
    
    html.window.onKeyDown.listen((event) => actions[keys[event.keyCode]] = true);
    html.window.onKeyUp.listen((event) => actions[keys[event.keyCode]] = false);
    
    p = new Player(this, 0, 0, 20, 50, 300);
    
    time = 0;
    wallTime = new DateTime.now().millisecondsSinceEpoch;
  }
  
  gameLoop([_]) {
    // call gameLoop as quickly as possible to try and acheive 60 fps.
    async.Future future = html.window.animationFrame;
    future.then(gameLoop);
    
    // find out how much time has elapsed so we can move our player smoothly.
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    int dt = currentTime - wallTime;
    if (dt > maxStep) {
      dt = maxStep;
    }
    
    // resolve the players input actions from the keyboard then call their update function.
    p.input(actions);
    p.update(dt);
    
    // clear the screen then draw background and player.
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgb(255,255,255)';
    ctx.fillRect(100, 100, 100, 100);
    ctx.fillRect(300, 300, 50, 50);
    ctx.fillRect(500, 100, 30, 123);
    ctx.fillRect(50, 420, 525, 60);
    p.draw();
  }
}

class Player {
  Game g;
  
  int x, y, w, h, speed;
  
  int dx;
  int dy;
  
  Player(this.g, this.x, this.y, this.w, this.h, this.speed);
  
  input(Map<String, bool> actions) {
    dx = 0;
    dy = 0;
    if (actions['left'] == true) {
      dx -= 1;
    }
    if (actions['up'] == true) {
      dy -= 1;
    }
    if (actions['right'] == true) {
      dx += 1;
    }
    if (actions['down'] == true) {
      dy += 1;
    }
  }
  
  update(final int dt) {
    final int msPerSec = 1000;
    final int xx = dx*speed*dt~/msPerSec;
    final int yy = dy*speed*dt~/msPerSec;
    if (x + xx < 0) {
      x = 0;
    } else if (x + w + xx > g.canvas.width) {
      x = g.canvas.width - w;
    } else {
      x += xx;
    }
    if (y + yy < 0) {
      y = 0;
    } else if (y+h+yy > g.canvas.height) {
      y = g.canvas.height - h;
    } else {
      y += yy;
    }
  }
  
  draw() {
    g.ctx.fillStyle = 'rgba(255, 0, 0, .9)';
    g.ctx.fillRect(x, y, w, h);
  }
}
