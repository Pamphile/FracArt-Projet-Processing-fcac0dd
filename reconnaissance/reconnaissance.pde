// Les paramètres de notre fenêtre
PImage imageImportee;
int dimension;
int [][] pixels;
int x, y, location, locationBas, locationDroite;

void setup() {
  size(500, 500);
  smooth();
  background(255 ,255,255);
  imageImportee = loadImage("imageTEST22.png");
  
  dimension = (imageImportee.width*imageImportee.height);
  pixels = new int [imageImportee.width][imageImportee.height];
  imageImportee.loadPixels();
  
  for(x = 0; x <imageImportee.width; x++){
    for(y = 0; y <imageImportee.height; y++){
      
      location = x * imageImportee.width + y;
      locationBas = (x + 1)* imageImportee.width + y;
      locationDroite = x* imageImportee.width + y + 1;
      
      color pix = imageImportee.pixels[location];
      color pixBas = imageImportee.pixels[locationBas];
      color pixDroite = imageImportee.pixels[locationDroite];
      
      float diff = abs(brightness(pix) - brightness(pixBas)) + abs(brightness(pix) - brightness(pixDroite));
      imageImportee.pixels[location]= color(diff);
      
    }
  }
  print(imageImportee.width);
  
  
  
  
  
  
  
  
  
  
  image(imageImportee, 0,0,500,500);
}


void draw() { // On est obligé de mettre dra dans le code processing (en général sert à faire des actions à une fréquence donnée)

}
