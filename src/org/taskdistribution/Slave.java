package org.taskdistribution;

/**
 * @author Bela Ban
 * @version $Id: Slave.java,v 1.1 2008/09/04 11:45:14 belaban Exp $
 */
public interface Slave {
    Object handle(Task task);
}
