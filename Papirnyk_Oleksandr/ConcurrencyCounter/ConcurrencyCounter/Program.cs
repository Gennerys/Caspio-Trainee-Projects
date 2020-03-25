using System;


namespace ConcurrencyCounter
{
    class Program
    {
        static void Main(string[] args)
        {
            UserHelper userInput = new UserHelper();
            Controller applicationController = new Controller();
            string readInput = string.Empty;
           

            bool isEnded = false;
            do
            {
                userInput.ShowMessage("Do you want to input via console or use cmd args?\nType \"console\" or \"cmd\" respectively: ");
                string selection = userInput.GetConsoleInput(readInput).ToLower();
                switch (selection)
                {
                    case "cmd":
                        applicationController.StartApplicationWithCmdArgs(args);
                        isEnded = true;
                        break;
                    case "console":
                        applicationController.StartApplicationWithConsoleInput();
                        isEnded = true;
                        break;
                    default:
                        userInput.ShowMessage("You inputed wrong value, please type \"console\" or \"cmd\"");
                        break;
                }
            } while (!isEnded);



            Console.ReadKey();
          
        }
    }
}
