import nodeMailer from 'nodemailer';
import { completeQuestionMarks } from './sql';
import { newUserTemplate, passwordRecoveryTemplate } from './mailerTemplates';

const transporter = nodeMailer.createTransport({
    service: process.env.MAILER_SERV,
    auth: {
        user: process.env.MAILER_USER,
        pass: process.env.MAILER_PASS
    }
});

const sendEmail = (email: string, subject: string, html: string) => {
    const mailOptions = {
        from: process.env.MAILER_USER,
        to: email,
        subject: subject,
        html: html
    };

    return new Promise((resolve, reject) => {
        transporter.sendMail(mailOptions, function(error, info) {
            if (error) {
                console.log(error);
                reject(error);
            } else {
                console.log('Email was sent: ' + info.response);
                resolve(info);
            }
        });
    });
}

export const sendNewUserEmail = (email: string, firstName: string, lastName: string) => {
    if (!email) throw new Error('Mailer - email is missing');
    const html = completeQuestionMarks(newUserTemplate.html, [firstName, lastName, email]);
    return sendEmail(email, newUserTemplate.subject, html);
}

export const sendPasswordRecoveryEmail = (email: string) => {
    if (!email) throw new Error('Mailer - email is missing');
    const html = completeQuestionMarks(passwordRecoveryTemplate.html, [email]);
    return sendEmail(email, passwordRecoveryTemplate.subject, html);
}