#Hello Canvas!

In this step we will get your environment set up and write a simple program to get a canvas on the screen. I use the [Dart Editor](http://dartlang.org). You can follow along using it or try to adapt to your environment. I will be explaining things assuming you have downloaded the Dart Editor though.

Once you've downloaded the Editor, start it up and create a new project. This can be done from by choosing _File_ > _New Project_ or from clicking the Create an application button on the Welcome screen.

In the New Project screen choose _webapp_ or _ubersimplewebapp_ from the project templates. These options may change in the future. I'll go over all the files and directories you need though so your environment should be the same as mine. Enter a project name and choose where you would like to save it on your computer.

The _webapp_ project will generate a lot of junk. We will go ahead and delete most of it. If you have the option of _upersimplewebapp_ there will be much less you need to delete. First open up the **pubspec.yaml** file.

In the bottom of the _Pubspec Details_ tab switch from _Overview_ to _Source_. Then make the following changes to the **pubspec.yaml**.

```yaml
name: 'yourGameNameHere'
version: 0.0.1
description: A platform shooter game built with dart and canvas.
environment:
  sdk: '>=1.0.0 <2.0.0'
dependencies:
  browser: any
```

Let's go over this quick. This file is how dart handles dependencies. It also acts as a package manager and downloads/updates the packages you depend on. I don't plan on using any outside libraries, but if you were going to use one this is where you would specify it. Are only dependency is the _browser_ package. This is what will allow dart to be run in the browser. You can find more info on the [dart website](http://dartlang.org).

Next, you can delete the entire lib directory. When we decide to extract some of the functionality of our game out in to separate libraries we can add it back. In the Dart Editor you can right click on the folder in the _Files_ window and choose _Delete_ to remove it.

Delete **CHANGELOG.md**. Delete or change the contents of **LICENSE** **README.md** to suit your needs. I kept them but the are unnecessary for the sake of this tutorial.

Open the _web_ folder if it is not open. Delete the _images_ folder. Open the _styles_ folder. Delete all the files here. We will come back later and add a css file.

In the _web_ folder delete all the files except **index.html** and **main.dart**.

Now open **index.html** and change its contents to the following.

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>platormShooterTutorial</title>

    <link rel="stylesheet" href="styles/main.css">
</head>
<body>

<canvas id="game"></canvas>
<script type="application/dart" src="main.dart"></script>
<script data-pub-inline src="packages/browser/dart.js"></script>
</body>
</html>
```

Here we declare the document type to be _html_ which is the html5 standard doctype. The _head_ tag tells the browser to use utf-8 charset. The next few lines in the header make the site "mobile friendly". I'm not sure if the game itself will be mobile friendly but we'll leave it in for now.
the link tag is for a style sheet we will create next.

In the body we create a _canvas_ element with an id of "game". This is where we will be doing all the drawing. I don't set a width and height in the canvas element because we will actually be changing the width and height in the dart code. The last two lines are what hooks dart up to your web app.

Next, we'll create a new file in the _styles_ directory. Right click _styles_ and choose _New File_. give it the name **main.css**. Modify the file so it looks like this.

```css
@import url(https://fonts.googleapis.com/css?family=Roboto);

html, body {
    background: rgb(0,0,0);
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Roboto', sans-serif;
}

canvas {
  display: block;
}
```

Here we set a couple default styles. The background is set to black. The width and height will fill the whole window and we take off all the margins and padding. The imported font is optional. I think it looks nice.


You will end up with a directory structure something like this.

```
platformShooterTutorial
|   .gitignore
|   LICENSE
|   pubspec.lock
|   pubspec.yaml
|   README
|
+---Lessons
|       Step_01.md
|
+---packages
|   \---browser
\---web
|   index.html
|   main.dart
|
+---packages
|   \---browser
\---styles
|   main.css
|
\---packages
\---browser
```

Now to the good stuff. Open up **main.dart** and delete all the contents. Enter the following into contents.

```dart
import 'dart:html';

void main() {

}
```

The import statement allows you to use all the DOM elements and document functions. This pretty much gives you the same features as vanilla JavaScript. If you come from a Java, C/C++, or Go background then you are probably familiar with the _main()_ function. If you have only worked with JavaScript then know the _main()_ function is where dart code begins execution.

At this point you can build and run the app. You should get a black screen. If there are any errors check that your **pubspec.yaml** is correct and that all your files are named correctly.

Now, let's finally draw something on the screen. In the main function add the following lines.

```dart
// get the canvas element from the web page.
CanvasElement canvas = querySelector('#game');
// change the default canvas size
canvas.width = 640;
canvas.height = 480;
// get the rendering context from the canvas
CanvasRenderingContext2D ctx = canvas.context2D;
```

Hopefully you know the first line is a comment. If not I recommend going to [dart website](http://dartlang.org) and familiarizing yourself with the language a little.

We declare a new variable `canvas`. In dart you can either give a specific (strong) type to a variable or you can give it a generic (weak) `var` type. Types in dart are pretty much just annotations. They allow better debugging in dart's checked mode but are stripped in the _production_ code. I like to use the strong types because it makes the code easier to read and the editor is able to provide better _autocomplete_ functionality. There are a whole bunch of other good reasons to use strong types, but let's focus on building a game.

`CanvasElement` is the DOM element for a canvas. We use the `querySelector` function from dart's `html` package to grab the element that matches `#game` from **index.html**. This is similar to the JavaScript function that matches the css style selectors. Next we set the width and height of our canvas element. In the last line we create a variable to hold the rendering context of our canvas. The rendering context has all the drawing functions for the canvas. The `canvas.context2D` is a quicker way of writing `canvas.getContext('2d')` which you might recognize from JavaScript.

Last step! Let's draw some boxes.

```dart
// draw a red and blue square on the canvas
ctx.clearRect(0, 0, canvas.width, canvas.height);
ctx.fillStyle = 'rgb(255,0,0)';
ctx.fillRect(128, 128, 256, 256);
ctx.fillStyle = 'rgba(0, 0, 255, .7)';
ctx.fillRect(0, 0, 256, 256);
```

Before we go into the code there is one important thing to know. When you are drawing on the canvas the axis is different than what you may be familiar with. The center (0,0) is in the top left corner. And increasing values of the y axis go down. The effect is something like this.

```
   (0,0)  (1,0)  (2,0)
     +------+------+----
     |
(0,1)+    (1,1)
     |
(0,2)+
```

Alright, let's go line by line. On our context variable we call the method `clearRect`. This erases everything on the canvas in this area defined by it's parameters. `clearRect(x, y, width, height);` Where `x` and `y` are the coordinates of the top-left corner.

Then we set the `fillStyle` for our ctx. This controls the colors of what is drawn after it is defined. This color will be used for all future draw calls until it is set to something else. `fillStyle` can take many different forms of values. I stick with the `rgb(int red, int green, int blue)` or `rgb(int red, int green, int blue,  double alpha)`. The `int` values can be in the range of 0 to 255. These specify the intensity of each color value. If you use `rgba` then the `alpha` value is a decimal between 0.0 and 1.0. This is the basically the opacity of the color or what percent it blends with the colors "behind" it. We set the red value to maximum intensity and leave all the others at zero.

Next we call `fillRect`. It draws a box on the canvas with its surface filled in to the color we set with `fillStyle`. There is also a `strokeRect` which just draws the border of the box. Just like `clearRect` this takes an `x`, `y` `width` and `height`.

Next two lines should look familiar. We change the `fillStyle` here, and supply an alpha value. This will make it look like we are drawing a transparent box over the red box we just drew on the canvas. Here the blue value is set to maximum intensity and the alpha value 70 percent. This means our color will blend 70% blue and 30% of the color already on the canvas.

Let it rip! Hit the run button and you should now see a black screen with a blue and red square. Hooray! This isn't a game though, so next time let's get to work on that.
