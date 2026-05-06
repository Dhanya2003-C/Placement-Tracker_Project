<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Application" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Tracker — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/tracker.css">
</head>
<body>

<%@ include file="/jsp/navbar.jsp" %>


<%
    List<Application> apps = (List<Application>) request.getAttribute("apps");
    
    Integer appliedObj   = (Integer) request.getAttribute("applied");
    Integer interviewObj = (Integer) request.getAttribute("interview");
    Integer selectedObj  = (Integer) request.getAttribute("selected");
    Integer rejectedObj  = (Integer) request.getAttribute("rejected");

    int applied   = appliedObj   != null ? appliedObj   : 0;
    int interview = interviewObj != null ? interviewObj : 0;
    int selected  = selectedObj  != null ? selectedObj  : 0;
    int rejected  = rejectedObj  != null ? rejectedObj  : 0;
%>

<div class="tracker-wrapper">

    <div class="tracker-header">
        <h2>Application Tracker</h2>
    </div>

    <div class="status-summary">
        <div class="summary-card">
            <div class="summary-num num-applied"><%= applied %></div>
            <div class="summary-lbl">Applied</div>
        </div>
        <div class="summary-card">
            <div class="summary-num num-interview"><%= interview %></div>
            <div class="summary-lbl">Interview</div>
        </div>
        <div class="summary-card">
            <div class="summary-num num-selected"><%= selected %></div>
            <div class="summary-lbl">Selected</div>
        </div>
        <div class="summary-card">
            <div class="summary-num num-rejected"><%= rejected %></div>
            <div class="summary-lbl">Rejected</div>
        </div>
    </div>

    <div class="add-form">
        <h3>Add New Application</h3>
        <form action="<%= request.getContextPath() %>/tracker"
              method="post">
            <input type="hidden" name="action" value="add" />

            <div class="form-row">
                <div class="form-field">
                    <label>Company Name</label>
                    <input type="text" name="companyName"
                           placeholder="e.g. TCS" required />
                </div>
                <div class="form-field">
                    <label>Role</label>
                    <input type="text" name="role"
                           placeholder="e.g. Software Engineer" required />
                </div>
            </div>

            <div class="form-row-3">
                <div class="form-field">
                    <label>Status</label>
                    <select name="status">
                        <option value="applied">Applied</option>
                        <option value="interview">Interview</option>
                        <option value="selected">Selected</option>
                        <option value="rejected">Rejected</option>
                    </select>
                </div>
                <div class="form-field">
                    <label>Applied Date</label>
                    <input type="date" name="appliedDate" />
                </div>
                <div class="form-field">
                    <label>Notes</label>
                    <input type="text" name="notes"
                           placeholder="Any notes..." />
                </div>
            </div>

            <button type="submit" class="btn-primary">Add Application</button>
        </form>
    </div>

    <div class="app-table">
        <% if (apps == null || apps.isEmpty()) { %>
            <div class="empty-state">
                No applications yet. Add your first one above!
            </div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Company</th>
                        <th>Role</th>
                        <th>Applied Date</th>
                        <th>Status</th>
                        <th>Notes</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Application app : apps) { %>
                    <tr>
                        <td><span class="company-name">
                            <%= app.getCompanyName() %>
                        </span></td>
                        <td><%= app.getRole() %></td>
                        <td><%= app.getAppliedDate() != null
                                ? app.getAppliedDate() : "-" %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/tracker"
                                  method="post" style="margin:0;">
                                <input type="hidden" name="action"
                                       value="updateStatus" />
                                <input type="hidden" name="appId"
                                       value="<%= app.getId() %>" />
                                <select name="status"
                                        class="status-select status-<%= app.getStatus() %>"
                                        onchange="this.form.submit()">
                                    <option value="applied"
                                        <%= "applied".equals(app.getStatus())
                                            ? "selected" : "" %>>Applied</option>
                                    <option value="interview"
                                        <%= "interview".equals(app.getStatus())
                                            ? "selected" : "" %>>Interview</option>
                                    <option value="selected"
                                        <%= "selected".equals(app.getStatus())
                                            ? "selected" : "" %>>Selected</option>
                                    <option value="rejected"
                                        <%= "rejected".equals(app.getStatus())
                                            ? "selected" : "" %>>Rejected</option>
                                </select>
                            </form>
                        </td>
                        <td><%= app.getNotes() != null
                                ? app.getNotes() : "-" %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/tracker"
                                  method="post" style="margin:0;"
                                  onsubmit="return confirm('Delete this application?')">
                                <input type="hidden" name="action"
                                       value="delete" />
                                <input type="hidden" name="appId"
                                       value="<%= app.getId() %>" />
                                <button type="submit"
                                        class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
</body>
</html>