const S3 = require('aws-sdk/clients/s3');
const fs = require('fs');
const util = require('util');

const bucketName = process.env.AWS_BUCKET_NAME;
const region = process.env.AWS_BUCKET_REGION;

const s3 = new S3({
    region: region,
});

// Uploads a file to S3
const uploadFile = (file, folder) => {
    const fileStream = fs.createReadStream(file.path);

    const uploadParams = {
        Bucket: bucketName,
        Body: fileStream,
        Key: `${folder}/${file.filename}`
    };

    return s3.upload(uploadParams).promise();
};

// retreive file from S3
const getFileStream = (fileKey) => {
    console.log(fileKey);
    const downloadParams = {
        Key: fileKey,
        Bucket: bucketName
    };

    return s3.getObject(downloadParams).createReadStream();
};

// Delete file from S3
const deleteFile = (fileKey) => {
    const deleteParams = {
        Bucket: bucketName,
        Key: fileKey
    };

    return s3.deleteObject(deleteParams).promise();
}

// Delete a file from uploads directory
// (not really s3 related, but this is a convienient place to put it)
const unlinkFile = util.promisify(fs.unlink);

module.exports = {
    uploadFile,
    getFileStream,
    deleteFile,
    unlinkFile
};
