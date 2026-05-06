package model;


public class Application {

    private int    id;
    private int    user_id;
    private String companyName;
    private String role;
    private String status;
    private String appliedDate;
    private String notes;

    public Application() {}

    public Application(int userId, String companyName, String role,
                       String status, String appliedDate, String notes) {
        this.user_id      = userId;
        this.companyName = companyName;
        this.role        = role;
        this.status      = status;
        this.appliedDate = appliedDate;
        this.notes       = notes;
    }

    public int    getId()                  { return id; }
    public void   setId(int id)            { this.id = id; }

    public int    getUserId()              { return user_id; }
    public void   setUserId(int userId)    { this.user_id = userId; }

    public String getCompanyName()                     { return companyName; }
    public void   setCompanyName(String companyName)   { this.companyName = companyName; }

    public String getRole()                { return role; }
    public void   setRole(String role)     { this.role = role; }

    public String getStatus()              { return status; }
    public void   setStatus(String status) { this.status = status; }

    public String getAppliedDate()                     { return appliedDate; }
    public void   setAppliedDate(String appliedDate)   { this.appliedDate = appliedDate; }

    public String getNotes()               { return notes; }
    public void   setNotes(String notes)   { this.notes = notes; }
}