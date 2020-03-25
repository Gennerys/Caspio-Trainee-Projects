using System;
using System.Threading.Tasks;
using System.Threading;
using System.Diagnostics;


namespace ConcurrencyCounter
{

    public  class ThreadStarter
    {       
        public void ProccessThreadPoolMethod(int threadCount, int threadToIncrement)
        {
            UserHelper userHelper = new UserHelper();
            Task[] taskArray = new Task[threadCount];
            Counter counterInstance = new Counter();

            Stopwatch stopwatch =  Stopwatch.StartNew();
            
            for (int i = 0; i < taskArray.Length; i++)
            {

                taskArray[i] = Task.Factory.StartNew(() =>
                {
                    int counter = 0;

                    for (int j = 0; j < threadToIncrement; j++)
                    {
                        counterInstance.Increment();
                        counter++;

                    }
                    userHelper.ShowMessage($"This thread #{Thread.CurrentThread.ManagedThreadId} and did {counter} incrementations");
                    
                });

            }

            Task.WaitAll(taskArray);
            stopwatch.Stop();
            userHelper.ShowMessage("RunTime: " + stopwatch.Elapsed.TotalMilliseconds);

            userHelper.ShowMessage($"Final indicator count : { counterInstance.GetCount()}");
        }



        
    }
}
