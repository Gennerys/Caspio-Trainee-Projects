
namespace ConcurrencyCounterThreads
{
    public class Controller
    {
        public void StartApplicationWithCmdArgs(string[] args)
        {
            int[] results = new int[2];

            Validator validator = new Validator();

            if (validator.ValidateInputCommandArgs(args, ref results))
            {
                ThreadStarter threadStarter = new ThreadStarter();
                threadStarter.ProccessThreadPoolMethod(results[0], results[1]);
            }
        }

        public void StartApplicationWithConsoleInput()
        {
            UserHelper userHelper = new UserHelper();
            ThreadStarter threadStarter = new ThreadStarter();
            threadStarter.ProccessThreadPoolMethod(userHelper.GetThreadCount(), userHelper.GetArrayOfThreadIncrement());
        }
    }
}

