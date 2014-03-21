package org.taskdistribution;

/**
 * @author Bela Ban
 * @version $Id: Master.java,v 1.3 2008/09/05 07:14:00 belaban Exp $
 */
public interface Master {
    Object submit(Task task, long timeout) throws Exception;
}
