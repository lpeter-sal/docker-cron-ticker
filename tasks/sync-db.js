let times = 0;

const syncDB = () => {
    times++;
    console.log('Tick each multiple of 5: ', times );

    return times;
}


module.exports = {
    syncDB
}