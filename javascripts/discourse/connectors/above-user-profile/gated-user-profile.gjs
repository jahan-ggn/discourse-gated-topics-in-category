import Component from "@glimmer/component";
import { service } from "@ember/service";
import TopicInGatedCategory from "../../components/topic-in-gated-category";

export default class GatedUserProfile extends Component {
  @service currentUser;

  constructor() {
    super(...arguments);
  }

  get shouldShowGate() {
    const userProfile = this.args.model;

    // Case 1: Anonymous user
    if (!this.currentUser) {
      return true;
    }

    const isInsider = this.currentUser.groups?.some(
      (g) => g.name === "insider"
    );

    // Case 2: Logged in, non-insider, accessing another user's profile
    if (!isInsider && userProfile.id !== this.currentUser.id) {
      return true;
    }

    return false;
  }

  <template>
    {{#if this.shouldShowGate}}
      <TopicInGatedCategory @forceShow={{true}} />
    {{/if}}
  </template>
}
