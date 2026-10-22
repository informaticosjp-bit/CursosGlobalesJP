using System.Collections.Concurrent;

namespace CursosCertificadosApp.Services
{
    public interface IUserActivityTracker
    {
        void RecordActivity(int userId);
        bool IsOnline(int userId);
    }

    public class UserActivityTracker : IUserActivityTracker
    {
        private readonly ConcurrentDictionary<int, DateTime> _lastActivity = new();
        private readonly TimeSpan _onlineThreshold = TimeSpan.FromMinutes(15);

        public void RecordActivity(int userId)
        {
            _lastActivity[userId] = DateTime.UtcNow;
        }

        public bool IsOnline(int userId)
        {
            if (_lastActivity.TryGetValue(userId, out var lastSeen))
            {
                return (DateTime.UtcNow - lastSeen) <= _onlineThreshold;
            }
            return false;
        }
    }
}
