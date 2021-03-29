# ShopApp
![](https://badges.fyi/github/latest-tag/AndresR173/ShopApp)
![](https://badges.fyi/github/stars/AndresR173/ShopApp)
![](https://badges.fyi/github/license/AndresR173/ShopApp)
![GitHub Build Status](https://github.com/AndresR173/ShopApp/workflows/Swift/badge.svg)
[![codecov](https://codecov.io/gh/AndresR173/ShopApp/branch/main/graph/badge.svg?token=8H3F0HWP4M)](https://codecov.io/gh/AndresR173/ShopApp)

A simple product catalog powered by MeLi API.

## Getting Started

This project uses `SwiftLint` to enforce Swift style and conventions. To run this project, please use Xcode 12.4 and iOS 13.0+.

### Using [Homebrew](http://brew.sh/):
```
brew install swiftlint
```

## Project details

### Architecture
This project uses MVVM as architectural design pattern.

### UI
There is a mix of UI concepts. The main view (Categories and Product catalog) uses XIB files for the layout. The product details screen uses programmatic UI.
## API
This project uses [Mercado Libre public API](https://developers.mercadolibre.com.co/es_ar/usuarios-y-aplicaciones) for all HTTP requests.
The networking is handled by [NSURLSession](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) and Combine.

## Third party dependencies

- [ImageSlideShow](https://github.com/zvonicek/ImageSlideshow)
- [Lottie](https://github.com/airbnb/lottie-ios)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## ShopApp Demo
![countdown](https://github.com/AndresR173/ShopApp/blob/main/shopapp.gif)

 License
 ----


MIT License

Copyright (c) 2021 Andres Rojas

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: 

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
