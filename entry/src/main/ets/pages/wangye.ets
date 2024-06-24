@Entry
@Component
struct SecondPage {
  controller: WebController = new WebController();

  build() {
    Column() {
      Web({ src: $rawfile('index.html'), controller: this.controller })
    }
  }
}