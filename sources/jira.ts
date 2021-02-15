import JiraClient from "jira-connector";

export class Jira {
  client: any;

  constructor(jiraSite: string, jiraUser: string, jiraToken: string) {
    this.client = new JiraClient({
      host: `${jiraSite}.atlassian.net`,
      basic_auth: {
        username: jiraUser,
        password: jiraToken
      }
    });
  }
  
  async transitionTicket(ticketNumber: string, state: string, message: string): Promise<any> {
    await this.client.issue.transitionIssue({
        issueKey: ticketNumber,
        transition: { id: state }
    });

    await this.client.issue.addComment({
      issueKey: ticketNumber,
      body: message
    });

    return true;
  }
}
  