/*
 * This file is part of Cockpit.
 *
 * Copyright (C) 2023 Red Hat, Inc.
 *
 * Cockpit is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * Cockpit is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Cockpit; If not, see <http://www.gnu.org/licenses/>.
 */
function getSecondaryServerAddress() {
    // Localhost: /cockpit/@localhost/machines/index.html
    // Primary server: /cockpit/@localhost/machines/index.html
    // Secondary server: /cockpit/@admin@kvm-02-guest05.rhts.eng.brq.redhat.com/machines/index.html
    const parts = window.location.pathname.split('@');

    if (parts.length === 0)
        return "";

    const parts2 = parts[parts.length - 1].split('/');

    if (parts2.length === 0)
        return "";

    return parts2[0];
}

function getPrimaryServerAddress() {
    return window.location.href;
}

function isLocalhost(address) {
    return address === "localhost" || address.startsWith("127");
}

// Get address where VNC or SPICE server is located
export function getConsoleAddress(consoleDetails) {
    let address = consoleDetails.address;

    if (!address || isLocalhost(address))
        address = getSecondaryServerAddress();

    if (!address || isLocalhost(address))
        address = getPrimaryServerAddress();

    return address;
}
