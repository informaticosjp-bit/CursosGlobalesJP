namespace CursosCertificadosApp.Services
{
    public class DatabaseBackupFileInfo
    {
        public string FileName { get; set; } = string.Empty;
        public string FilePath { get; set; } = string.Empty;
        public long FileSizeBytes { get; set; }
        public DateTime CreatedAt { get; set; }
        public string FormattedSize => FileSizeBytes switch
        {
            < 1024 => $"{FileSizeBytes} B",
            < 1024 * 1024 => $"{FileSizeBytes / 1024.0:N1} KB",
            _ => $"{FileSizeBytes / (1024.0 * 1024.0):N2} MB"
        };
    }

    public class DatabaseStatsViewModel
    {
        public string DatabaseName { get; set; } = string.Empty;
        public string Provider { get; set; } = string.Empty;
        public bool IsConnected { get; set; }
        public Dictionary<string, int> TableCounts { get; set; } = new();
        public int TotalRecords { get; set; }
        public List<DatabaseBackupFileInfo> BackupFiles { get; set; } = new();
    }

    public interface IDatabaseBackupService
    {
        Task<DatabaseStatsViewModel> GetDatabaseStatsAsync();
        Task<(byte[] FileBytes, string FileName)> CreateJsonBackupAsync(string createdBy);
        Task<(byte[] FileBytes, string FileName)> CreateSqlBackupAsync();
        Task<(bool Success, string Message)> RestoreFromJsonStreamAsync(Stream stream);
        Task<(bool Success, string Message)> RestoreFromSqlStreamAsync(Stream stream);
        Task<(bool Success, string Message)> RestoreFromAnyStreamAsync(Stream stream, string fileName);
        Task<(bool Success, string Message)> RestoreFromLocalFileAsync(string fileName);
        Task<(bool Success, string Message)> ResetSystemAsync(string masterPassword = "master141990");
        List<DatabaseBackupFileInfo> GetBackupHistory();
    }
}
