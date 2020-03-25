using System;
using System.Threading;
using System.Diagnostics;

namespace ConcurrencyCounterThreads
{
    public class ThreadStarter
    {
        public void ProccessThreadPoolMethod(int threadCount, int threadToIncrement)
        {
            UserHelper userHelper = new UserHelper();

            Thread[] threadArray = new Thread[threadCount];

            Counter counterInstance = new Counter();

            AutoResetEvent[] resetEvents = new AutoResetEvent[threadCount];

            Stopwatch stopwatch = Stopwatch.StartNew();

            for (int i = 0; i < threadArray.Length; i++)
            {
                int counter = 0;
                resetEvents[i] = new AutoResetEvent(false);
                counterInstance = new Counter(resetEvents[i]);
                threadArray[i] = new Thread(() => Incrementation(threadToIncrement, counterInstance, counter, userHelper));
                threadArray[i].Start();
            }

            WaitHandle.WaitAll(resetEvents, new TimeSpan(0, 0, 5), false);

            foreach (var _event in resetEvents)
            {
                _event.Dispose();
            }

            stopwatch.Stop();
            userHelper.ShowMessage("RunTime: " + stopwatch.Elapsed.TotalMilliseconds);
            userHelper.ShowMessage($"Final indicator count : { counterInstance.GetCount()}");
        }

        void Incrementation(int numberOfIncrements, Counter counterInstance, int counter, UserHelper userHelper)
        {
            for (int j = 0; j < numberOfIncrements; j++)
            {
                counterInstance.Increment();
                counter++;
            }
            userHelper.ShowMessage($"This thread #{Thread.CurrentThread.ManagedThreadId} and did {counter} incrementations");
        }
    }
}

