// Les paramètres de notre fenêtre
PImage imageImportee;
int dimension;
int [][] pixels;
int x, y, location, locationBas, locationDroite;
float seuil = 40;

// Par rapport à la fonction de parcours
// La taill du tableau est mise à 21x21 -> 10 + 10  + 0 = 21 right ? 
int tailleTableau_next = 10;

//     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//     0123456789
//  y0
//  y1
//  y2
//  y3
//  y 
//  y
class Point{
  int x;
  int y;
}


void setup() {
  size(500, 500);
  smooth();
  background(255 ,255,255);
  imageImportee = loadImage("imageTest.png");
  
  dimension = (imageImportee.width*imageImportee.height);
  pixels = new int [imageImportee.width][imageImportee.height];
  imageImportee.loadPixels();
  
  for(x = 0; x <imageImportee.width; x++){
    for(y = 0; y <imageImportee.height-1; y++){
      
      location = y * imageImportee.width + x;
      locationBas = (y + 1)* imageImportee.width + x;
      locationDroite = y* imageImportee.width + x + 1;
      
      color pix = imageImportee.pixels[location];
      color pixBas = imageImportee.pixels[locationBas];
      color pixDroite = imageImportee.pixels[locationDroite];
      
      float diff = abs(brightness(pix) - brightness(pixBas)) + abs(brightness(pix) - brightness(pixDroite));
      if (diff < seuil )
      {
        diff = 0;
      }
      else
      {
        diff = 255;
      }
      imageImportee.pixels[location]= color(diff);
    }
  }

  
  // Maintenant on parcours le zouinzouin :D
  Point courant = new Point();
  courant.x = -1;
  courant.y = -1;
  // On commence par trouver une pixel allumé
  x = 150;
  y = 170;
  while(x <imageImportee.width && courant.x == -1 ){
    while(y <imageImportee.height && courant.y == -1 ){
      location = y * imageImportee.width + x;
      if(brightness(imageImportee.pixels[location]) > 120)
      {
        courant.x = x;
        courant.y = y;
      }
      y++;      
    }
    x++;
  }
  
  image(imageImportee, 0,0,500,500);
  fill(255,125,125);
  ellipse(courant.x,courant.y,16,16);
  for (int i = 0; i< 20; i++)
  {
    courant = next(courant);
    fill(255,125,125);
    ellipse(courant.x,courant.y,16,16);
  }
}

Point next(Point actuel){
  Point suivant = new Point();
  pixels = new int [imageImportee.width][imageImportee.height];
  imageImportee.loadPixels();
  int location = 0;
  
  // A partir d'ici, on travail en coordonnée relative
  for (x = -1* tailleTableau_next; x<=tailleTableau_next; x++)
  {
    for (y = -1* tailleTableau_next; x<=tailleTableau_next; y++)
    { 
      print("x = "+ actuel.x + "    y =   " + actuel.y + "\n");
      print(location + "\n");
      location = (y + actuel.y) * imageImportee.width + (x + actuel.x);
      color pix = imageImportee.pixels[location];
      
      if (brightness(pix) > 120)
      {
          suivant.x +=x;
          suivant.y +=y;
      }
    }
  }
  // On repasse en coordonnée absolue
  suivant.x = suivant.x + actuel.x;
  suivant.y = suivant.y + actuel.y;
  return suivant;
}

void draw() { // On est obligé de mettre dra dans le code processing (en général sert à faire des actions à une fréquence donnée)

}
