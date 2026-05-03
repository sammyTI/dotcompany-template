export default function ActivityFeed({ data, onNavigate }) {
  const activities = data.recentActivity || [];

  const handleClick = (a) => {
    if (!onNavigate || !a.department || !a.file) return;
    // a.file is relative to .company/, e.g. "secretary/notes/2026-03-18.md"
    // Strip the department prefix to get the path within the department.
    const prefix = a.department + "/";
    const filePath = a.file.startsWith(prefix) ? a.file.slice(prefix.length) : a.file;
    onNavigate("department", a.department, filePath);
  };

  return (
    <div className="section">
      <div className="section-title">Recent Activity</div>
      {activities.length === 0 ? (
        <div className="empty-state">No recent activity</div>
      ) : (
        activities.slice(0, 15).map((a, i) => (
          <div
            key={i}
            className="activity-item activity-item-clickable"
            onClick={() => handleClick(a)}
            role="button"
            tabIndex={0}
            onKeyDown={(e) => (e.key === "Enter" || e.key === " ") && handleClick(a)}
          >
            <span className="activity-dept">{a.department}</span>
            <span className="activity-file">{a.file}</span>
            <span className="activity-time">{timeAgo(a.modifiedAt)}</span>
          </div>
        ))
      )}
    </div>
  );
}

function timeAgo(iso) {
  const diff = Date.now() - new Date(iso).getTime();
  const min = Math.floor(diff / 60000);
  if (min < 1) return "just now";
  if (min < 60) return `${min}m ago`;
  const hrs = Math.floor(min / 60);
  if (hrs < 24) return `${hrs}h ago`;
  return `${Math.floor(hrs / 24)}d ago`;
}
