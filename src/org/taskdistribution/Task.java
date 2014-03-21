package org.taskdistribution;

import java.io.Serializable;

/** A task contains all of the necessary data that is shipped to a slave. The execute() method then uses that data
 * to execute and returns a result, which is sent back to the master who submitted the task
 * @author Bela Ban
 * @version $Id: Task.java,v 1.2 2008/09/04 12:58:52 belaban Exp $
 */
public interface Task extends Serializable {
    public abstract Object execute();
}
