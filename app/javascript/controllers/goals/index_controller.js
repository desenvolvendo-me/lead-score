import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static values = {finishEndpoint: String}
    static targets = ["checkbox"];

    finishingMany() {
        const ids = this.checkboxTargets
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);
        const finishEndpoint = this.finishEndpointValue;

        const data = {goal_ids: ids};
        const url = finishEndpoint + '.json';
        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': token,
            },
            body: JSON.stringify(data),
        })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }
}