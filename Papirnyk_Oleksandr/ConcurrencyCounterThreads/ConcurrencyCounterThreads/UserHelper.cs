using System;

namespace ConcurrencyCounterThreads
{
    class UserHelper
    {
        public int GetThreadCount()
        {
            ShowMessage("Enter thread counter: ");
            int counter = Convert.ToInt32(Console.ReadLine());

            return counter;
        }

        public int GetArrayOfThreadIncrement()
        {
            ShowMessage("Enter number of incrementations: ");
            int threadIncrementCounts = Convert.ToInt32(Console.ReadLine());

            return threadIncrementCounts;
        }

        public void ShowMessage(string input)
        {
            Console.WriteLine(input);
        }

        public string GetConsoleInput(string input)
        {
            input = Console.ReadLine();
            return input;
        }
    }
}

