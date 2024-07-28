using static System.Formats.Asn1.AsnWriter;
using System.Buffers.Text;
using System.Diagnostics.Metrics;
using System.Numerics;
using System.Runtime.Intrinsics.X86;
using System.Text;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Collections.Generic;
using System.Reflection;
using System.Security.Principal;

namespace ObjectOOPDayThree
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Calcullator cal=new Calcullator();

            //ref type
            //int x = 0;
            //int y = 20;

            //Console.WriteLine($"{x} x , {y} y");
            //cal.Swap(ref x,ref y);
            //Console.WriteLine($"{x} x , {y} y");


            //out type
            //double salary=29000;
            //double tax=3000;
            //int inHand;
            //int spended=20000;

            //double leftAmount=cal.BillCallculation(salary, tax, out inHand, spended);
            //Console.WriteLine($"the amount save : {leftAmount}");
            //Console.WriteLine($"the inHand salary is : {inHand}");


            //params array type
            //string[] itemList = ["juiceCan","Apple","Book","Pen"];
            //int morningItem = 3;
            //int afternonItem = 1;
            //cal.TotalItem(morningItem, afternonItem, "hello", "hadj", "hdagsj");
            //int count=cal.TotalItem(morningItem,afternonItem,itemList);
            //Console.WriteLine($"total item count is : {count}");
            //Console.WriteLine($"List of item are : {cal.TotalItem(morningItem,afternonItem,itemList)}");


            // ***************************************************************************//



            //            Problem Statement: Create a Player class with properties for Name, RunsScored, and BallsFaced.Write methods to calculate the StrikeRate (runs scored per 100 balls faced). Implement a program to input details for eleven players, calculate their strike rates, and display the results in descending order of strike rates.
            //•	Define a Player class.
            //•	Use an array to store player objects.
            //•	Implement a method to calculate and return the strike rate.
            //•	Sort players based on their strike rates in descend
            //Sample Output :
            //Enter name of player 1: Player1
            //Enter runs scored by Player1: 45
            //Enter balls faced by Player1: 30
            //Enter name of player 2: Player2
            //Enter runs scored by Player2: 60
            //Enter balls faced by Player2: 50
            //...
            //Player Statistics:
            //Name: Player1, Runs: 45, Balls: 30, Strike Rate: 150.00
            //Name: Player2, Runs: 60, Balls: 50, Strike Rate: 120.00


            //string name;
            //int runScored;
            //int ballsFaced;
            //Player p = new Player();
            //Player[] obj = new Player[1];
            //for (int i = 0; i < obj.Length; i++)
            //{
            //    Console.WriteLine("name : ");
            //    name = Console.ReadLine();
            //    Console.WriteLine("runScored : ");
            //    runScored = Convert.ToInt32(Console.ReadLine());
            //    Console.WriteLine("ballsFaced : ");
            //    ballsFaced = Convert.ToInt32(Console.ReadLine());

            //    obj[i] = new Player(name, runScored, ballsFaced,p.StrikeRate(runScored, ballsFaced));
            //    //Console.WriteLine(obj[i]);
            //}
            //foreach (Player p2 in obj) 
            //{
            //    //Array.Sort(p2);
            //    p2.DisplayInOrder();
            //}


            //Create a method to Calculate the Result for a student..Get 5 marks from the user The method should return both the total and grade point

            //Movie m = new Movie();


            //*******************************************************************************

//            Create a class Mobile with the following members
//MobileType(only 2 types are allowed Pay as you go or pay monthly
//        Device type of phone
//        phone number
//account balance(initially it is set to zero and should be  account activated)

//The following functions should be carried out on a mobile account perspective
//•	Declare constants CALL_COST and TEXT_COST.
//•	Set CALL_COST to equal 0.545 and TEXT_COST to equal 0.075
//•	Top up account with credit
//•	Make a call – reduces credit
//•	Send a text – reduces cr








        }
    }
}
