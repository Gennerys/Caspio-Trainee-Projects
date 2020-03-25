using System.Threading;

namespace ConcurrencyCounterThreads
{
    public class Counter
    {
        private static int _indicator;

        AutoResetEvent _are;

		public Counter(AutoResetEvent are)
		{
			_are = are;
		}

		public Counter() => _indicator = 0;

        public void Increment()
        {
			Interlocked.Increment(ref _indicator);
			_are.Set();
        }

        public int GetCount() => _indicator;
    }
}

