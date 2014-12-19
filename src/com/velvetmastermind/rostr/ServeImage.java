package com.velvetmastermind.rostr;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.images.Image;
import com.google.appengine.api.images.ImagesServiceFactory;

@SuppressWarnings("serial")
public class ServeImage extends HttpServlet {

    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        BlobKey blobKey = new BlobKey(req.getParameter("blob-key"));

        blobstoreService.serve(blobKey, res);

        Datastore ds = new Datastore(req, res, new ArrayList<String>());

        ds.setImage(req.getParameter("blob-key"));

        if(req.getParameter("upload") != null){

            res.sendRedirect("edit-info");
        }
    }
}