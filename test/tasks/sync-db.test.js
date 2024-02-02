const { syncDB } = require("../../tasks/sync-db");


describe('Probar la funcion sync-db', () => { 

    test('Debe de ejecutar el proceso 2 veces', () => { 
        syncDB();
        syncDB();
        const times = syncDB();

        expect( times ).toBe(3);
    });
});