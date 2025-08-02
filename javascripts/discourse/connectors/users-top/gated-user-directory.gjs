import Component from "@glimmer/component";
import { service } from "@ember/service";
import TopicInGatedCategory from "../../components/topic-in-gated-category";

export default class GatedUserDirectory extends Component {
  @service currentUser;

  get shouldShowGate() {
    // Case 1: Anonymous user
    if (!this.currentUser) {
      return true;
    }

    // Case 2: Logged-in but not in insider group
    const isInsider = this.currentUser.groups?.some(
      (group) => group.name === "insider"
    );
    return !isInsider;
  }

  <template>
    {{#if this.shouldShowGate}}
      <TopicInGatedCategory @forceShow={{true}} />
    {{/if}}
  </template>
}
