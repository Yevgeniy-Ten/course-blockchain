const fs = require('fs');
const https = require('https');



for (let i = 0; i < 10; i++) {
    https.get('https://cataas.com/cat', (response) => {
        response.pipe(fs.createWriteStream(`${i}.png`));
    });
}
console.log('Изображения успешно загружены и сохранены.');
