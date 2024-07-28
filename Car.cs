using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ObjectOOPDayThree
{
    internal class Car
    {
        string petName;
        string color;
        double speed;

        public  Car()
        {
        }
        public Car(string petName, string color, double speed)
        {
            this.petName = petName;
            this.color = color;
            this.speed = speed;
        }
        public Car(string petName) { 
            this.petName = petName;
        }
        public Car(double speed) { 
            this.speed=speed;
        }

        public void Display()
        {
            Console.WriteLine("{0} is the petName , {1} is the color of the car ," +
                " {2} is the speed",petName,color,speed);

            Console.WriteLine($"{this.petName} is the petName , {this.color} is the color of the car ,{this.speed} is the speed");
        }

        public Double Accelerate(double delta)
        {
            speed += delta;
            return speed;
        }



    }
}
