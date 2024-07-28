using System;
using System.Buffers.Text;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Runtime.Intrinsics.X86;
using System.Text;
using System.Threading.Tasks;
using static System.Formats.Asn1.AsnWriter;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ObjectOOPDayThree
{

//    Problem Statement: Create a Player class with properties for Name, RunsScored, and
//    BallsFaced.Write methods to calculate the StrikeRate (runs scored per 100 balls faced).
//    Implement a program to input details for 3 players, calculate their strike rates,
//    and display the results in descending order of strike rates.
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
    internal class Player
    {
        string name;
        int runScored;
        int ballsFaced;
        int strikeRate;

        public Player()
        {

        }

        public Player(string name, int runScored, int ballsFaced,int strikeRate)
        {
            this.name = name;
            this.runScored = runScored;
            this.ballsFaced = ballsFaced;
            this.strikeRate = strikeRate;
        }

        public int StrikeRate(int runScored,int ballsFace)
        {
            int temp = (runScored/ballsFace)*100;
            strikeRate= temp;
            return temp;
        }
        public void DisplayInOrder()
        {

            Console.WriteLine($"Name:{this.name}, Runs:{this.runScored}, Balls:{this.ballsFaced}, Strike Rate:{this.strikeRate}");
            
        }
        public void PlayerSort(Player[] ar)
        {
            
            for (int i = 0; i < ar.Length; i++) 
            {
               
            }
        }
        public int GetstrikeRate()
        {
            return strikeRate;
        }
        public void SetstrikeRate(int strikeRate)
        {
            this.strikeRate= strikeRate;
        }




    }
}
