const apiVersion = 'v2.6';
const namespace = 'drops';
const dataEndpointUrl = 'api/$apiVersion/data';

const storiesEndpoint = '$namespace/stories';
const profileEndpoint = '$namespace/profile';
const childrenEndpoint = '$namespace/children';

const storiesEndpointUrl = '$dataEndpointUrl/$storiesEndpoint';
const profileEndpointUrl = '$dataEndpointUrl/$profileEndpoint';
const childrenEndpointUrl = '$dataEndpointUrl/$childrenEndpoint';