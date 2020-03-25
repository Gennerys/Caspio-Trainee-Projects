using System;

namespace ConcurrencyCounterThreads
{
    public class Validator
    {
        public bool ValidateInputCommandArgs(string[] args, ref int[] results)
        {
            if (args.Length != 2)
            {
                throw new ArgumentException("Please, input only 2 parameters");
            }
            else
            {
                bool checkedThreadCount = int.TryParse(args[0], out results[0]);
                bool checkedThreadIncrementationsCount = int.TryParse(args[1], out results[1]);

                if (checkedThreadCount && checkedThreadIncrementationsCount)
                {
                    return true;
                }
                else
                {
                    throw new ArgumentException("Please, input only integer values");
                }
            }
        }
    }
}

