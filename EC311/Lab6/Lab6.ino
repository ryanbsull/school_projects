/************************************************
/    EK307Spring2015
// EK307 Microcontroller Lab Arduino starter code
// Copyright (Your name here!!) Boston University 2015
// This program monitors a temperature sensor and
// toggles and LED based on the state of the sensor.
// Based on free to use or modify software written 
// by Aleks Zosuls for
// EK307 at Boston University.
**************************************************/

//comment lines of code with two slashes
/* comment blocks of code with slash-star end with star-slash
All lines of code except control statements and defines terminate with a semicolon */

const int WarningLED = 7; /*this defines the variable WarningLED to have an integer value 7. The value corresponds
to a digital Pin number. 7 was chosen for no reason other than it is not being used for any other function.
Pin number 13 is connected to the on board Arduino green LED. 
If you want to connect your LED to a different pin change the number to another avialable digital output.
This method of defining the pins makes more readable code plus it is easier to change the pin since it is only
specified once in the code.*/

const int Thermistor = 0; //defines analog input pin that interfaces thermistor
float tV = 0;
int t_val = 0;
int ADCValueBinary = 0;  //declare a variable for the ADC read. In C all variables need to be declared before use.
int alarmThreshold = 500; //declare a variable that is the threshold for the alarm to trigger. THis corresponds to a digitized
//voltage that is determined by the thermistor circuit. The value may not be correct for your circuit.

/*void is a function that returns no values. The function void setup() is run the first time your code executes.
Code in the curly braces after the function call is what is run in the function */

void setup() {
  /*put your setup code here, to run once. Typical things you want to run once are initialization of variables,
  port settings etc.*/
  pinMode(WarningLED, OUTPUT); //sets the warning LED pin as a digital output
  Serial.begin(9600);          /*  setup a serial port to enable comms with the computer. 
                                This is very useful for debugging and or sending values to the console.*/
  Serial.println("Operational");  //write a line to the console to tell us the code is working
  
  //flash the warning led twice with a 1 second delay to let us know it is working
  digitalWrite(WarningLED, HIGH);
  delay(1000);
  digitalWrite(WarningLED, LOW);
  delay(1000);
  digitalWrite(WarningLED, HIGH);
  delay(1000);
  digitalWrite(WarningLED, LOW);
  
  Serial.println("Starting temperature alarm program");
  

}  //end of setup function

/* Embedded computing usually runs a bit differently from a console app like you may have made in Ek128.
In most beginning programming classes you typically execute your code then it returns a value upon exiting. In embedded programs we 
often want some aspect of the code to run forever. Think of a vending machine -- you always want it checking for inserted money. 
The microcontroller sits in an endless loop periodically (say once a hundred milliseconds) checking the coin slot. When it detects 
money it runs a counting routine. In our temperature alarm we want to periodically read the value of the thermistor, decode it, then
decide if the LED should light or not.*/

void loop() {
  // put your main code here, to run repeatedly:
                               //read the voltage on the thermistor resistor junction
                               //print the value of the ADC to the console
                               ADCValueBinary = analogRead(Thermistor);
                               tV = ((float)ADCValueBinary)*(5.0/1023.0);
                               Serial.print("ADC Binary Value: ");
                               Serial.println(tV);
                               //control statement. if greater than, do something
                                if(tV > 2.65)
                                {
                                  delay(233);
                                  digitalWrite(WarningLED, HIGH);
                                  delay(333);
                                  digitalWrite(WarningLED, LOW);
                                  delay(333);
                                  digitalWrite(WarningLED, HIGH);
                                  delay(333);
                                  digitalWrite(WarningLED, LOW);
                                  delay(333);
                                  digitalWrite(WarningLED, HIGH);
                                  delay(333);
                                  digitalWrite(WarningLED, LOW);
                                  
                                }
                                else if(tV < 2.0)
                                {
                                  delay(900);
                                  digitalWrite(WarningLED, HIGH);
                                  delay(1000);
                                  digitalWrite(WarningLED, LOW);
                                }
                                else
                                {
                                  digitalWrite(WarningLED, LOW);
                                }
                              //wait 100 milliseconds and repeat the loop
                              delay(100);
} //end of loop function
