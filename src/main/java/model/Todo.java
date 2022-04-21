package model;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Objects;

public class Todo implements Serializable {
    private Long id;
    private String description;
    private Boolean isDone;
    private LocalDate targetDate;
    private String username;
    private String title;

    protected Todo(){super();}

    public Todo(Long id, String description, Boolean isDone, LocalDate targetDate, String username, String title){
        super();
        this.id = id;
        this.description = description;
        this.isDone = isDone;
        this.targetDate = targetDate;
        this.username = username;
        this.title = title;
    }

    public Todo(String description, Boolean isDone, LocalDate targetDate, String username, String title){
        super();
        this.description = description;
        this.isDone = isDone;
        this.targetDate = targetDate;
        this.username = username;
        this.title = title;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getDone() {
        return isDone;
    }

    public void setDone(Boolean done) {
        isDone = done;
    }

    public LocalDate getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(LocalDate targetDate) {
        this.targetDate = targetDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Todo todo = (Todo) o;
        return Objects.equals(id, todo.id) && Objects.equals(description, todo.description) && Objects.equals(isDone, todo.isDone) && Objects.equals(targetDate, todo.targetDate) && Objects.equals(username, todo.username) && Objects.equals(title, todo.title);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, description, isDone, targetDate, username, title);
    }

    @Override
    public String toString() {
        return "Todo{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", isDone=" + isDone +
                ", targetDate=" + targetDate +
                ", username='" + username + '\'' +
                ", title='" + title + '\'' +
                '}';
    }
}
