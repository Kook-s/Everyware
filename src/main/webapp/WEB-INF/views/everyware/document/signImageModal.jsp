<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <title>1. Basic</title>
  <link type="text/css" href="https://uicdn.toast.com/tui-color-picker/v2.2.6/tui-color-picker.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.css"/>
</head>

<body>
  <div id="tui-image-editor"></div>
  </div>
  <script src="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.js"></script>
  <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js"></script>
  <script type="text/javascript" src="https://uicdn.toast.com/tui-color-picker/v2.2.6/tui-color-picker.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.3/FileSaver.min.js"></script>
  <script>
    const ImageEditor = require('tui-image-editor');
    const instance = new ImageEditor(document.querySelector('#tui-image-editor'), {
      includeUI: {
        loadImage: {
          path: 'img/sampleImage.jpg',
          name: 'SampleImage',
        },
        theme: whiteTheme, // or whiteTheme
        initMenu: 'filter',
        menuBarPosition: 'bottom',
      },
      cssMaxWidth: 700,
      cssMaxHeight: 500,
      selectionStyle: {
        cornerSize: 20,
        rotatingPointOffset: 70,
      },
    });
  </script>
</body>
</html>