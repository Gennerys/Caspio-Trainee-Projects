namespace ConcurrencyCounter
{
    public class Counter
    {
        private object _locker = new object();

        private int _indicator;

        public Counter() => _indicator = 0;

        public void Increment()
        {
            lock (_locker)
            {
                _indicator++;
            }
        }

        public int GetCount() => _indicator;
        
    }
}
