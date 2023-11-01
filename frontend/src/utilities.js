const BACKEND_URL = "http://localhost:4000";

/**
 * @typedef BackendFetchOptions
 * @prop {Record<string, unknown>} body
 * @prop {"POST" | "GET"} method
 */

/**
 * @param {string} route
 * @param {BackendFetchOptions | undefined} options
 */
export function backend(route, options) {
	if (options == undefined) options = {};
	if (options.method == undefined) options.method = "GET";

	let url = BACKEND_URL.concat(route);
	let body = undefined;
	let headers = undefined;

	if (options.method == "GET") {
		let searchParams = new URLSearchParams(options.body).toString();
		url = url.concat("?", searchParams);
	} else if (options.method == "POST") {
		headers = new Headers();
		headers.set("Content-Type", "application/json");
		body = JSON.stringify(options.body);
	}

	return fetch(url, {
		method: options.method,
		headers,
		body
	}).then((response) => {
		if (response.status != 200) {
			return response.text();
		}
		const contentType = response.headers.get("Content-Type");
		if (
			typeof contentType == "string" &&
			contentType.startsWith("application/json;")
		) {
			return response.json();
		}
	});
}
