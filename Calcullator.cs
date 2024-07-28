using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ObjectOOPDayThree
{
    internal class Calcullator
    {
        

        //methode overloading
        public int Add(int x, int y)
        {
            return x + y;
        }
        public float Add(float x, int y)
        {
            return x + y;
        }
        public float Add(float x, float y)
        {
            return x + y;
        }

        //example for reference type
        public void Swap(ref int x,ref int y)
        {
            int temp = x;
            x = y;
            y = temp;
        }

        //example for out type
        public double BillCallculation(double salary,double tax,out int inHand,int spended)
        {
            inHand = (int)(salary - tax);
            return (double)(inHand-spended);

        }

        //example of params array type this parram array
        //should be given at the end 
        public int TotalItem(int morningItem, int afternonItem, params String[] itemList)
        {
            foreach (string str in itemList)
            {
                Console.WriteLine(str);
            }
            return morningItem + afternonItem;
        }

        //optional type
        public void Employe(int id,string name,string city = "Mumbai")
        {
            //here if in program.cs we dont pass the city argument it will take mumbai as the city name
            //by default
            // optional type should also be written in the last
            Console.WriteLine($"employee id is : {id} , employee name is : {name} , employee city : {city}");

        }








    }
}
